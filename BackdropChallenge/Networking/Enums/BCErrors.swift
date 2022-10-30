//
//  BCErrors.swift
//  BackdropChallenge
//
//  Created by Ibukunoluwa Soyebo on 27/10/2022.
//

import Foundation

enum BcError: Error{
    case apiError
    case timeout
    case session
    case invalidEndpoint
    case invalidResponse
    case serverError
    case notJson
    case noData
    case serializationError
    case custom(Error)
    
    var localizedDescription: String{
        switch self{
        case .apiError: return "Failed to fetch data, check internet connection"
        case .timeout: return "Request took longer than expected to fetch data"
        case .session: return "Failed to start session"
        case .invalidEndpoint: return "Invalid endpoint"
        case .invalidResponse: return "Invalid response"
        case .serverError: return "server encountered an issue and cannot process the request"
        case .notJson: return "Response not in JSON format"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        case .custom(let error): return error.localizedDescription
        }
    }
    
    var errorUserInfo: [String : Any]{
        [NSLocalizedDescriptionKey: localizedDescription ]
    }
}
