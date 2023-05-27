//
//  NetworkManager.swift
//  FarmProducts
//
//  Created by Khusain on 26.05.2023.
//

import Foundation
import Alamofire


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

enum Link {
    case product
    case order
    case delivery
    case category
    case login
    case register
    
    var url: URL? {
        switch self {
        //TODO: - Заменить URL с деплоя
        case .product:
            return URL(string: "http://farmyou.localhost/api/product")
        case .order:
            return URL(string: "http://farmyou.localhost/api/order")
        case .delivery:
            return URL(string: "")
        case .category:
            return URL(string: "http://farmyou.localhost/api/category")
        case .login:
            return URL(string: "http://farmyou.localhost/api/login")
        case .register:
            return URL(string: "http://farmyou.localhost/api/register")
        }
    }
    
    var post: URL? {
        switch self {
        //TODO: - Заменить URL с деплоя
        case .product:
            return URL(string: "farmyou.localhost/api/product")
        case .order:
            return URL(string: "")
        case .delivery:
            return URL(string: "")
        case .category:
            return URL(string: "")
        case .login:
            return URL(string: "http://farmyou.localhost/api/login")
        case .register:
            return URL(string: "http://farmyou.localhost/api/register")
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
    
    func sendPostRequest(to url: URL?, with data: ProductAdapter) {
        guard let url = url else {
            return
        }
        
        AF.request(url, method: .post, parameters: data)
            .validate()
            .responseString { response in
                print(response)
            }
    }
    
}
