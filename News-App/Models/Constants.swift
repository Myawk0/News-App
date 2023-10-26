//
//  Constants.swift
//  News-App
//
//  Created by Мявкo on 26.10.23.
//

import UIKit

struct K {
    
    // MARK: - CategoriesCollectionViewController constants

    struct CategoriesCollection {
        static let title = "Категории"
        static let cellIdentifier = "CategoryCell"
        
        static let contentInset = UIEdgeInsets(top: 50, left: 15, bottom: 0, right: 15)
        static let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let edgeInset: CGFloat = 10
        static let space: CGFloat = 20
        
        static let width = (UIScreen.main.bounds.width - 80) / 2
        static let height = width - 30
        static var itemSize: CGSize {
            return CGSize(width: width, height: height)
        }
    }
    
    // MARK: - NewsTableViewController constants
    
    struct NewsTable {
        static let title = "Список новостей"
        static let cellIdentifier = "NewsItemCell"
        
        static let contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }
    
    // MARK: - DetailsViewController constants
    
    struct DetailsView {
        static let title = "Детальная информация"
    }
}
