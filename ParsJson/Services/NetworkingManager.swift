//
//  NetworkingManager.swift
//  ParsJson
//
//  Created by Лилия Андреева on 14.11.2023.
//

import Foundation
import Alamofire

enum Link {
    case userUrl
    
    var url: URL {
        switch self {
        case .userUrl:
            return URL(string: "https://random-data-api.com/api/v2/users?size=100&is_xml=true")!
        }
    }
}


final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    //    func fetchUsers <T: Decodable>(_ tupe: T.Type, from url: URL, complition: @escaping(Result<T, NetworkError>) -> Void) {
    //        
    //         URLSession.shared.dataTask(with: url) { data, response, error in
    //             if let response = response as? HTTPURLResponse {
    //                 print("response status code: \(response.statusCode)")
    //             }
    //             
    //            guard let data = data else {
    //                complition(.failure(.noData))
    //                return
    //            }
    //            
    //            do {
    //                let decoder = JSONDecoder()
    ////                decoder.keyDecodingStrategy = .convertFromSnakeCase
    //                let type = try decoder.decode(T.self, from: data)
    //                DispatchQueue.main.async {
    //                    complition(.success(type))
    //                }
    //            } catch {
    //                complition(.failure(.decodingError))
    //            }
    //        }.resume()
    //    }
    
    func fetchUsers(from url: URL, complition: @escaping(Result<[User], AFError>) -> Void){
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let usersData = value as? [[String: Any]] else {return}
                    let users = User.getUsers(from: value)
                    complition(.success(users))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
        }
        
//        func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
//            DispatchQueue.global().async {
//                guard let imageData = try? Data(contentsOf: url) else {
//                    completion(.failure(.noData))
//                    return
//                }
//                DispatchQueue.main.async {
//                    completion(.success(imageData))
//                }
//            }
//        }
        
    func fetchData(from url: String, complition: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponce in
                switch dataResponce.result {
                    
                case .success(let imageData):
                    complition(.success(imageData))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
        }
    }



