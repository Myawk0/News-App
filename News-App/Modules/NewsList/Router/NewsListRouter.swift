//
//  NewsListRouter.swift
//  News-App
//
//  Created by Мявкo on 25.10.23.
//

import UIKit

protocol NewsListRouterInput: AnyObject {
    func routeToNewsDetailsScreen(newsDetails: NewsItem)
    func showAlert()
}

final class NewsListRouter: NewsListRouterInput {
    
    weak var view: UIViewController?
    
    func routeToNewsDetailsScreen(newsDetails: NewsItem) {
        let detailsController = DetailsBuilder.createNewsDetailsModule(with: newsDetails)
        view?.navigationController?.pushViewController(detailsController, animated: true)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Похоже новостей тут нет", message: "Придется вернуться обратно", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Okay", style: .default) { action in
            self.view?.navigationController?.popViewController(animated: true)
        }
        
        alert.addAction(okAction)
        view?.present(alert, animated: true, completion: nil)
    }
}
