//
//  NetworkError.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
}
