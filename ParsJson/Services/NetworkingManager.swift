//
//  NetworkingManager.swift
//  ParsJson
//
//  Created by Лилия Андреева on 14.11.2023.
//

import Foundation

enum Link {
    case imageUrl
    case userUrl
    
    var url: URL {
        switch self {
            
        case .imageUrl:
            return URL(string: "https://randomfox.ca/images/60.jpg")!
        case .userUrl:
            return URL(string: "https://random-data-api.com/api/v2/users?size=100&is_xml=true")!
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    func fetchUsers <T: Decodable>(_ tupe: T.Type, from url: URL, complition: @escaping(Result<T, NetworkError>) -> Void) {
        
         URLSession.shared.dataTask(with: url) { data, response, error in
             if let response = response as? HTTPURLResponse {
                 print("response status code: \(response.statusCode)")
             }
             
            guard let data = data else {
                complition(.failure(.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(type))
                }
            } catch {
                complition(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
