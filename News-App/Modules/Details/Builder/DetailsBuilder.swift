//
//  DetailsBuilder.swift
//  News-App
//
//  Created by Мявкo on 26.10.23.
//

import UIKit

final class DetailsBuilder {
    
    static func createNewsDetailsModule(with details: NewsItem) -> UIViewController {
        let presenter = DetailsPresenter(details: details)
        let view = DetailsViewController(presenter: presenter)
        
        presenter.view = view
        return view
    }
}

