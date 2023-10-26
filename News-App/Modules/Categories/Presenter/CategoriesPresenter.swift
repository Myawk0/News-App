//
//  CategoriesPresenter.swift
//  News-App
//
//  Created by Мявкo on 25.10.23.
//

import Foundation

class CategoriesPresenter {
    
    //MARK: - Properties
    
    weak var view: CategoriesViewProtocol?
    
    private let router: CategoriesRouterInput
    private let networkManager = NetworkManager.shared
    
    private var categories = [Category]() {
        didSet {
            view?.updateCollectionView()
        }
    }
    
    // MARK: - Init
    
    init(router: CategoriesRouterInput) {
        self.router = router
    }
    
    // MARK: - Count Categories
    
    var countCategories: Int {
        return categories.count
    }
    
    // MARK: - Get a Category
    
    func getCategory(at index: Int) -> Category {
        return categories[index]
    }
    
    // MARK: - Load list of Categories
    
    func getListOfCategories() {
        self.view?.activityStartAnimating()

        networkManager.fetchCategories { result in
            switch result {
            case .success(let categoriesList):
                self.categories = categoriesList
                self.view?.activityStopAnimating()
            case .failure(let error):
                print("Error getting categories list: \(error)")
            }
        }
    }
    
    // MARK: - Show News Table Screen
    
    func showNewsList(at index: Int) {
        let categoryID = categories[index].id
        router.routeToNewsListScreen(with: categoryID)
    }
}
