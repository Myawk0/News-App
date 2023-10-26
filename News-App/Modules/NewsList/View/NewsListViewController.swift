//
//  NewsListViewController.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import UIKit

protocol NewsListViewProtocol: AnyObject {
    func updateTableView()
    func activityStartAnimating()
    func activityStopAnimating()
}

class NewsListViewController: UITableViewController {
    
    private let presenter: NewsListPresenter
    
    // MARK: - Init
    
    init(presenter: NewsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getListOfNews()
        setupNavigationController()
        setupTableView()
    }
    
    // MARK: - Setup UINavigationController
    
    private func setupNavigationController() {
        navigationController?.setupNavigationBar()
        navigationController?.setupTitle(title: K.NewsTable.title)
    }
    
    // MARK: - Setup UITableView
    
    private func setupTableView() {
        tableView.register(NewsItemCell.self, forCellReuseIdentifier: K.NewsTable.cellIdentifier)
        tableView.contentInset = K.NewsTable.contentInset
        tableView.prefetchDataSource = self
    }
}

extension NewsListViewController {
    
    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countNews
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: K.NewsTable.cellIdentifier, for: indexPath) as? NewsItemCell else { return UITableViewCell() }
        
        let newsData = presenter.getNewsItem(at: indexPath.row)
        cell.setupNewsRow(title: newsData.title, date: newsData.date, description: newsData.shortDescription)
        cell.layoutIfNeeded()
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showNewsDetails(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSourcePrefetching (for pagination)

extension NewsListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        presenter.updateCurrentPage()
    }
}

// MARK: - NewsListViewProtocol

extension NewsListViewController: NewsListViewProtocol {
    func updateTableView() {
        tableView.reloadData()
    }
    
    func activityStartAnimating() {
        self.view.activityStartAnimating()
    }
    
    func activityStopAnimating() {
        self.view.activityStopAnimating()
    }
}
