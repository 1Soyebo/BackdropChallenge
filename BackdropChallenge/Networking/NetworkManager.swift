//
//  NetworkManager.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import Foundation
import UIKit


class NetworkManager {
    
    private let config = URLSessionConfiguration.default
    private var session: URLSession?
    private let jsonDecoder = Utils.jsonDecoder
    
    public typealias Parameters = [String: String]
    
    static let shared = NetworkManager()
    
    private init() {
        session = URLSession.init(configuration: config)
        config.timeoutIntervalForRequest = 60
    }
    
    func makeRequest<T:Decodable>(requestType:RequestType, url:String, params: [String: Any]? = nil,   completionHandler: @escaping (Result<T, BcError>)-> ()){
        
        //Create a url Component
        var urlComponent = URLComponents(string: url)
        
        //Extract the url from url Component
        
        guard let url = urlComponent?.url else {
            completionHandler(.failure(BcError.invalidEndpoint))
            return}
        
        //Use url to create a url request
        
        var request = URLRequest(url: url)
        
        //specify the http method
        request.httpMethod = requestType.rawValue
        let apiKey = Configuration.apiKey
        
        //Set Token
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        
        //Set headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Log the request parameters
        request.log()
        
        //Create a url parameter
        
        if let params = params {
            if requestType == .get {
                var queryItems = [URLQueryItem]()
                for (key,value) in params {
                    queryItems.append(URLQueryItem(name: key, value: "\(value)"))
                }
                urlComponent?.queryItems = queryItems
            }else {
                print(params)
                let requestBodyData = try? JSONSerialization.data(withJSONObject: params)
                request.httpBody = requestBodyData
            }
        }
        
        guard let session = session else {
            completionHandler(.failure(BcError.session))
            return
        }
        
        
        
        let task = session.dataTask(with: request) { [weak self] (data, response, error) in
            
            //Handle Device related error
            guard let self = self else { return }
            
            if error != nil {
                self.executeCompletionMainThread(with: .failure(BcError.apiError), completion: completionHandler)
                return
            }
            
            //Check the data return from the network request
            print(data?.toString() ?? "No Data")
            
            
            //Handle Server related error
            self.networkManagerCompletionHandler(response: response, data: data, completionHandler: completionHandler)
            
        }
        
        task.resume()
    }
    
    
    private func networkManagerCompletionHandler<T:Decodable>(response: URLResponse?, data: Data?, completionHandler: @escaping (Result<T, BcError>)-> ()){
        guard let httpResponse = response as? HTTPURLResponse else {
            self.executeCompletionMainThread(with: .failure(BcError.invalidResponse), completion: completionHandler)
            return}
        print("Status Code: \(httpResponse.statusCode)")
        
        switch httpResponse.statusCode {
            
        case (200...400):
            if !(httpResponse.mimeType == "application/json"){
                self.executeCompletionMainThread(with: .failure(BcError.notJson), completion: completionHandler)
                return
            }else {
                guard let data = data else {
                    self.executeCompletionMainThread(with: .failure(BcError.noData), completion: completionHandler)
                    return
                }
                
                do {
                    let decodedResponse = try self.jsonDecoder.decode(T.self, from: data)
                    self.executeCompletionMainThread(with: .success(decodedResponse), completion: completionHandler)
                    
                } catch(let error)  {
                    self.executeCompletionMainThread(with: .failure(.custom(error)), completion: completionHandler)
                }
            }
        case (401):
            fallthrough
        case (402...499):
            self.executeCompletionMainThread(with: .failure(BcError.serverError), completion: completionHandler)
        case (500...599):
            self.executeCompletionMainThread(with: .failure(BcError.serverError), completion: completionHandler)
        default:
            self.executeCompletionMainThread(with: .failure(BcError.invalidResponse), completion: completionHandler)
        }
    }
    
    private func executeCompletionMainThread<D: Decodable>(with result: Result<D, BcError>, completion: @escaping (Result<D, BcError>) -> ()){
        DispatchQueue.main.async {
            completion(result)
        }
    }
    

}
