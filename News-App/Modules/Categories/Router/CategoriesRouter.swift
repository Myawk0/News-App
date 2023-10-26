//
//  CategoriesRouter.swift
//  News-App
//
//  Created by Мявкo on 25.10.23.
//

import UIKit

protocol CategoriesRouterInput: AnyObject {
    func routeToNewsListScreen(with categoryID: Int)
}

final class CategoriesRouter: CategoriesRouterInput {
    
    weak var view: UIViewController?
    
    func routeToNewsListScreen(with categoryID: Int) {
        let newsController = NewsListBuilder.createNewsListModule(in: categoryID)
        view?.navigationController?.pushViewController(newsController, animated: true)
    }
}
