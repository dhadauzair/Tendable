//
//  EndpointService.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/13/24.
//

import Foundation

enum Environment: String{
    case localHost = "http://localhost:5001"
    case localHost127 = "http://127.0.0.1:5001"
}

enum EndpointService {
    case loginUser
    
    var urlString: String {
        switch self {
        case .loginUser:
            return APIBaseService.environment.rawValue + "/api/login"
        }
    }
    
    var url: URL {
        return URL(string: self.urlString)!
    }
    
    var httpMethod: String {
        switch self {
        case .loginUser:
            return "POST"
        }
    }
}
