//
//  NewsListBuilder.swift
//  News-App
//
//  Created by Мявкo on 25.10.23.
//

import UIKit

final class NewsListBuilder {
    
    static func createNewsListModule(in id: Int) -> UIViewController {
        let router = NewsListRouter()
        let presenter = NewsListPresenter(router: router, categoryID: id)
        let view = NewsListViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
