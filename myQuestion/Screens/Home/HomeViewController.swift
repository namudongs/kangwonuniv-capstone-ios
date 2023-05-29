//
//  HomeViewController.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit

class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setCustomNavigationBar()
        setupLayout()
        
        navigationController?.navigationBar.isHidden = false
        
        self.view.backgroundColor = .white
    }
    
    private lazy var collectionView: QuestionListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = QuestionListCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.customDelegate = self
        return collectionView
    }()
    
    private lazy var navigationBarView: UIStackView = {
        let hStackView = UIStackView()
        hStackView.setHorizontalStack()
        return hStackView
    }()
    
    private lazy var navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "지금 올라온 질문"
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.sizeToFit()
        return label
    }()
    
    private lazy var addQuestionButton: UIButton = {
        let button = UIButton(type: .system)
        let imageConfig = UIImage.SymbolConfiguration.init(pointSize: 18, weight: .regular)
        button.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: imageConfig), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(addQuestionButtontapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func addQuestionButtontapped() {
        navigationController?.pushViewController(QuestionCreateViewController(), animated: true)
    }
    
    private func setCustomNavigationBar() {
        navigationBarView.addArrangedSubviews(navigationTitleLabel, addQuestionButton)
        let space = view.frame.width - navigationTitleLabel.frame.width
        navigationBarView.spacing = space - 70
        
        navigationItem.titleView = navigationBarView
    }
    
    private func setupLayout() {
        view.addSubview(collectionView)
        
        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }
}

extension HomeViewController: QuestionListCollectionViewDelegate {
    func questionCellTapped(question: Question) {
        let detailViewController = QuestionDetailViewController()
        detailViewController.question = question
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
