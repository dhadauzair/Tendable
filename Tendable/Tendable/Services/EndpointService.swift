//
//  EndpointService.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/13/24.
//

import Foundation

enum Environment: String {
    case localHost = "http://localhost:5001"
    case localHost127 = "http://127.0.0.1:5001"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum EndpointService {
    case loginUser
    case startInspection
    case submitInspection
    
    var urlString: String {
        switch self {
        case .loginUser:
            return APIBaseService.environment.rawValue + "/api/login"
        case .startInspection:
            return APIBaseService.environment.rawValue + "/api/inspections/start"
        case .submitInspection:
            return APIBaseService.environment.rawValue + "/api/inspections/submit"
        }
    }
    
    var url: URL {
        return URL(string: self.urlString)!
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .loginUser, .submitInspection:
            return .post
        case .startInspection:
            return .get
        }
    }
}
