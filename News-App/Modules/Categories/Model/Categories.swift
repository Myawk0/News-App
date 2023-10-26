//
//  Categories.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import Foundation

struct Categories: Decodable {
    var code: Int
    var list: [Category]
}

struct Category: Decodable {
    var id: Int
    var name: String
}
