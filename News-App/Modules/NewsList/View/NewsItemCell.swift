//
//  NewsItemCell.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import UIKit

class NewsItemCell: UITableViewCell {
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .monospacedSystemFont(ofSize: 16, weight: .heavy)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .monospacedSystemFont(ofSize: 13, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .monospacedSystemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup cell
    
    func setupNewsRow(title: String, date: String, description: String) {
        titleLabel.text = title
        dateLabel.text = date.changeDateFormat()
        shortDescriptionLabel.text = description
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(shortDescriptionLabel)
        stackView.addArrangedSubview(dateLabel)
        contentView.addSubview(stackView)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
}
