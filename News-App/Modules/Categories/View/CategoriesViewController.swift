//
//  CategoriesViewController.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import UIKit

enum LoadingState {
    case loading
    case loaded
}

protocol CategoriesViewProtocol: AnyObject {
    func updateCollectionView()
    func activityStartAnimating()
    func activityStopAnimating()
}

class CategoriesViewController: UICollectionViewController {

    private let presenter: CategoriesPresenter
    
    // MARK: - Init
    
    init(presenter: CategoriesPresenter) {
        self.presenter = presenter
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.getListOfCategories()
        setupNavigationController()
        setupCollectionView()
    }
    
    // MARK: - Setup UINavigationController
    
    private func setupNavigationController() {
        navigationController?.setupTitle(title: K.CategoriesCollection.title)
    }
    
    // MARK: - Setup UICollectionView
    
    private func setupCollectionView() {
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: K.CategoriesCollection.cellIdentifier)
        collectionView.contentInset = K.CategoriesCollection.contentInset
    }
}

// MARK: UICollectionViewDataSource

extension CategoriesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.countCategories
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.CategoriesCollection.cellIdentifier, for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        
        let category = presenter.getCategory(at: indexPath.row)
        cell.setupTitle(with: category.name)
        
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension CategoriesViewController {
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        presenter.showNewsList(at: indexPath.row)
        return true
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoriesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return K.CategoriesCollection.edgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return K.CategoriesCollection.itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return K.CategoriesCollection.space
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return K.CategoriesCollection.space
    }
}

// MARK: - CategoriesViewProtocol

extension CategoriesViewController: CategoriesViewProtocol {
    
    func activityStartAnimating() {
        self.view.activityStartAnimating()
    }
    
    func activityStopAnimating() {
        self.view.activityStopAnimating()
    }
    
    func updateCollectionView() {
        collectionView.reloadData()
    }
}
