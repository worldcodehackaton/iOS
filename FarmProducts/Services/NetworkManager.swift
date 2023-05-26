//
//  NetworkManager.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import Foundation
import Alamofire

enum Link {
    case product
    case order
    case delivery
    case category
    
    var url: URL? {
        switch self {
        //TODO: - Заменить URL с деплоя
        case .product:
            return URL(string: "http://farmyou.localhost/api/product")
        case .order:
            return URL(string: "http://farmyou.localhost/api/order")
        case .delivery:
            return URL(string: "http://farmyou.localhost/api/delivery")
        case .category:
            return URL(string: "http://farmyou.localhost/api/category")
        }
    }
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL?, completion: @escaping(Result<T, AFError>) -> Void) {
        guard let url else {
            completion(.failure(.createURLRequestFailed(error: "No URL data" as! Error)))
            return
        }

        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { responseData in
                switch responseData.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchPost<T: Codable>(_ type: T.Type, to url: String, with data: T, completion: @escaping(Result<T, AFError>) -> Void) {
        AF.request(url, method: .post, parameters: data)
            .validate()
            .responseDecodable(of: T.self) { responseData in
                switch responseData.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
