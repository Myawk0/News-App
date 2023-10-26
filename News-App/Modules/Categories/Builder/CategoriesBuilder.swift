//
//  CategoriesBuilder.swift
//  News-App
//
//  Created by Мявкo on 25.10.23.
//

import UIKit

final class CategoriesBuilder {
    
    static func createCategoriesModule() -> UIViewController {
        let router = CategoriesRouter()
        let presenter = CategoriesPresenter(router: router)
        let view = CategoriesViewController(presenter: presenter)
        
        presenter.view = view
        router.view = view
        
        return view
    }
}
