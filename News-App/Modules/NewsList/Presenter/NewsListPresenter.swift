//
//  NewsListPresenter.swift
//  News-App
//
//  Created by Мявкo on 25.10.23.
//

import Foundation

class NewsListPresenter {
    
    //MARK: - Properties
    
    weak var view: NewsListViewProtocol?
    
    private let router: NewsListRouterInput
    private var networkManager = NetworkManager.shared
    
    private var selectedCategoryID: Int
    private var news = [NewsItem]() {
        didSet {
            view?.updateTableView()
        }
    }
    
    // for pagination in TableView while scrolling
    private var currentPage = 0
    private var threshold = 0
    
    // MARK: - Init
    
    init(router: NewsListRouterInput, categoryID: Int) {
        self.router = router
        self.selectedCategoryID = categoryID
    }
    
    // MARK: - Count of News
    
    var countNews: Int {
        return news.count
    }
    
    // MARK: - Get a News Item
    
    func getNewsItem(at index: Int) -> NewsItem {
        threshold += 1
        return news[index]
    }
    
    // MARK: - Load list of News
    
    func getListOfNews() {
        view?.activityStartAnimating()
        networkManager.fetchNews(categoryID: selectedCategoryID, pageNumber: currentPage) { result in
            switch result {
            case .success(let newsList):
                self.news.append(contentsOf: newsList)
                self.view?.activityStopAnimating()
            case .failure(let error):
                print(error)
            }
            
            if self.news.isEmpty {
                self.router.showAlert()
            }
        }
    }
    
    // MARK: - Update page while scrolling News
    
    func updateCurrentPage() {
        if threshold == 10 {
            currentPage += 1
            threshold = 0
            
            getListOfNews()
        }
    }
    
    // MARK: - Show Details of selected News Screen
    
    func showNewsDetails(at index: Int) {
        let details = news[index]
        router.routeToNewsDetailsScreen(newsDetails: details)
    }
}
