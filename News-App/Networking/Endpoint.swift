//
//  Endpoint.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import Foundation

enum Endpoint {
    case categories
    case news(id: Int)
    case details

    var path: String {
        switch self {
        case .categories:
            return "/v1/news/categories"
        case .news(let id):
            return "/v1/news/categories/\(id)/news"
        case .details:
            return "/v1/news/details"
        }
    }
}
