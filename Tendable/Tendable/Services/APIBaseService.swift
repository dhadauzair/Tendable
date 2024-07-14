//
//  APIBaseService.swift
//  Tendable
//
//  Created by Uzair Dhada on 7/13/24.
//

import Foundation

final class APIBaseService {
    static let shared = APIBaseService()
    static var environment = Environment.localHost
    
    private init() {}
    
    func request<T: Decodable>(_ endpoint: EndpointService, body: [String: Any] = [:], completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("URL: \(endpoint.url)")
        print("HTTPMETHOD: \(endpoint.httpMethod.rawValue)")
        print("HEADER: \(String(describing: request.allHTTPHeaderFields))")
        print("BODY: \(body)")
        
        let session = URLSession.shared
        if !body.isEmpty {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                print("Failed to serialize JSON")
                return
            }
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"])))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                if let data = data, data.count > 0 {
                    do {
                        let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(decodedResponse))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    // If there is no data but the status code indicates success
                    if T.self == BoolResponse.self {
                        completion(.success(BoolResponse(success: true) as! T))
                    } else {
                        completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                    }
                }
            } else {
                completion(.failure(NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Request failed with status code \(httpResponse.statusCode)"])))
            }
        }
        task.resume()
    }
}

struct BoolResponse: Codable {
    let success: Bool
}
