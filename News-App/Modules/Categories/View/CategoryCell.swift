//
//  CategoryCell.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import UIKit
import SnapKit

class CategoryCell: UICollectionViewCell {
    
    // MARK: - Views
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .monospacedSystemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup cell data
    
    func setupTitle(with title: String) {
        titleLabel.text = title
    }
    
    // MARK: - Setup cell appearance
    
    private func setupAppearance() {
        contentView.backgroundColor = .darkGray
        contentView.addShadow()
        contentView.layer.cornerRadius = 10
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}
