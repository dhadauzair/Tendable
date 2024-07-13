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
    
    func request<T: Decodable>(_ endpoint: EndpointService, completion: @escaping (Result<T, Error>) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Data Not Available"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }
        
        task.resume()
    }
    
    func request(_ endpoint: EndpointService, body: [String: Any], completion: @escaping (Result<Bool, Error>) -> Void) {
        var request = URLRequest(url: endpoint.url)
        request.httpMethod = endpoint.httpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print("URL: \(endpoint.url)")
        print("HTTPMETHOD: \(endpoint.httpMethod)")
        print("HEADER: \(String(describing: request.allHTTPHeaderFields))")
        print("BODY: \(body)")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            print("Failed to serialize JSON")
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Data Not Available"])
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                completion(.success(true))
            } else {
                do {
                    let errorMessage = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : errorMessage ?? "Unknown Error"])
                    completion(.failure(error))
                    print("Server error: \(String(describing: errorMessage))")
                } catch {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Server Error"])
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
