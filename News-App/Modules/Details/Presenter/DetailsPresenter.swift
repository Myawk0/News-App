//
//  DetailsPresenter.swift
//  News-App
//
//  Created by Мявкo on 26.10.23.
//

import Foundation

class DetailsPresenter {
    
    // MARK: - Properties
    
    weak var view: DetailsViewProtocol?
    private var networkManager = NetworkManager.shared

    private var newsDetails: NewsItem
    
    // MARK: - Init
    
    init(details: NewsItem) {
        self.newsDetails = details
    }
    
    // MARK: - Get Details of selected News (loaded)
    
    func getNewsDetails() -> NewsItem {
        return newsDetails
    }
    
    // MARK: - Load full description of selected news
    
    func loadFullDescription() {
        view?.activityStartAnimating()
        
        networkManager.fetchDetails(newsID: newsDetails.id) { result in
            switch result {
            case .success(let fullDescription):
                self.view?.loadFullDescription(from: fullDescription)
                self.view?.activityStopAnimating()
            case .failure(let error):
                print("Error getting categories list: \(error)")
            }
        }
    }
}
