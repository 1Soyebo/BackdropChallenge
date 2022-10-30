//
//  ApiServices.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import Foundation

protocol CatService: WebService{
    func getCatBreeds(completionHandler: @escaping (Result<[CatBreed], BcError>) -> ())
}

class ApiService: CatService{
    private let baseUrl = Configuration.baseUrl
    let networkManager = NetworkManager.shared
    
    static let shared = ApiService()
    
    func getCatBreeds(completionHandler: @escaping (Result<[CatBreed], BcError>) -> ()){
        networkManager.makeRequest(requestType: .get, url: baseUrl + Endpoints.breed.rawValue, completionHandler: completionHandler)
    }
}
