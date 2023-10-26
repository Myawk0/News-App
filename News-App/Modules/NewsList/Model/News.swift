//
//  News.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import Foundation

struct News: Decodable {
    var code: Int
    var list: [NewsItem]
}

struct NewsItem: Decodable {
    var id: Int
    var title: String
    var date: String
    var shortDescription: String
    var fullDescription: String?
}
