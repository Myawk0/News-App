//
//  ViewController.swift
//  News-App
//
//  Created by Мявкo on 24.10.23.
//

import UIKit

protocol DetailsViewProtocol: AnyObject {
    func loadFullDescription(from fullDescription: String)
    func activityStartAnimating()
    func activityStopAnimating()
}

class DetailsViewController: UIViewController {
    
    private let presenter: DetailsPresenter
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .monospacedSystemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .monospacedSystemFont(ofSize: 24, weight: .heavy)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .monospacedSystemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var fullDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .monospacedSystemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    // MARK: - Init
    
    init(presenter: DetailsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupLoadedNewsDetails()
        presenter.loadFullDescription()
        setupNavigationController()
        
        addSubviews()
        applyConstraints()
    }
    
    // MARK: - Setup UINavigationController
    
    private func setupNavigationController() {
        navigationController?.setupNavigationBar()
        navigationController?.setupTitle(title: K.DetailsView.title)
    }
    
    // MARK: - Setup News Details data
    
    private func setupLoadedNewsDetails() {
        let details = presenter.getNewsDetails()
        
        dateLabel.text = details.date.changeDateFormat()
        titleLabel.text = details.title
        shortDescriptionLabel.text = details.shortDescription
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(shortDescriptionLabel)
        headerView.addSubview(stackView)
        
        view.addSubview(headerView)
        view.addSubview(fullDescriptionLabel)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(110)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(280)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
        
        fullDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(15)
        }
    }
}

// MARK: - DetailsViewProtocol

extension DetailsViewController: DetailsViewProtocol {
    
    func activityStartAnimating() {
        self.view?.activityStartAnimating()
    }
    
    func activityStopAnimating() {
        self.view?.activityStopAnimating()
    }
    
    func loadFullDescription(from fullDescription: String) {
        fullDescriptionLabel.attributedText = fullDescription.attributedStringFromHTML()
    }
}

