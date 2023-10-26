//
//  NavigationController.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import UIKit

extension UINavigationController {
    
    // MARK: - Change "Back" button appearance
    
    func setupNavigationBar(with tintColor: UIColor = .darkGray) {
        let backButtonImage = UIImage(systemName: "chevron.backward")
        let alignInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        navigationBar.backIndicatorImage = backButtonImage?.withAlignmentRectInsets(alignInsets)
        navigationBar.backIndicatorTransitionMaskImage = backButtonImage
        navigationBar.tintColor = tintColor
        navigationBar.topItem?.title = ""
    }
    
    // MARK: - Setup Title
    
    func setupTitle(title: String, color: UIColor = .darkGray) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = color
        titleLabel.font = .monospacedSystemFont(ofSize: 22, weight: .bold)
        topViewController?.navigationItem.titleView = titleLabel
    }
}
