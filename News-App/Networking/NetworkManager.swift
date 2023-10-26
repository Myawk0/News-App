//
//  NetworkManager.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import Alamofire
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    // Make parameters
    private func makeParameters(for endpoint: Endpoint, with query: String?) -> [String: String] {
        var parameters = [String: String]()
        
        switch endpoint {
        case .news:
            parameters["page"] = query
        case .details:
            parameters["id"] = query
        default:
            break
        }
        
        return parameters
    }
    
    // Create URL for API method
    func createURL(for endPoint: Endpoint, with query: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endPoint.path
        
        components.queryItems = makeParameters(for: endPoint, with: query).compactMap {
            URLQueryItem(name: $0.key, value: $0.value)
        }
    
        return components.url
    }
    
    // Method for making task
    func makeTask<T: Decodable>(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        AF.request(url).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(.transportError(error)))
            }
        }
    }
}

extension NetworkManager {
    
    // MARK: - GET Categories
    
    func fetchCategories(completion: @escaping (Result<[Category], NetworkError>) -> Void) {
        guard let url = createURL(for: .categories) else { return }
        
        makeTask(for: url) { (result: Result<Categories, NetworkError>) in
            switch result {
            case .success(let categories):
                completion(.success(categories.list))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: -  GET News of selected Category
    
    func fetchNews(categoryID: Int, pageNumber: Int, completion: @escaping (Result<[NewsItem], NetworkError>) -> Void) {
        guard let url = createURL(for: .news(id: categoryID), with: "\(pageNumber)") else { return }
        
        makeTask(for: url) { (result: Result<News, NetworkError>) in
            switch result {
            case .success(let news):
                completion(.success(news.list))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: -  GET Details of selected News
    
    func fetchDetails(newsID: Int, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = createURL(for: .details, with: "\(newsID)") else { return }
        
        makeTask(for: url) { (result: Result<Details, NetworkError>) in
            switch result {
            case .success(let details):
                completion(.success(details.news.fullDescription ?? ""))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

