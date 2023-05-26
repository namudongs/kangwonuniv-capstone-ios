//
//  QuestionListCollectionViewDelegate.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/26.
//

import UIKit

protocol QuestionListCollectionViewDelegate: AnyObject {
    func questionCellTapped(question: Question)
}

final class QuestionListCollectionView: UICollectionView {
    
    weak var customDelegate: QuestionListCollectionViewDelegate?
    
    private let reuseIdentifier = "QuestionListCollectionViewCell"
    private let firebaseManager = FirebaseManager()
    
    // MARK: - init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        super.init(frame: frame, collectionViewLayout: layout)
        
        firebaseManager.dataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.reloadData()
            }
        }
        configureUI()
        configureCollectionView()
        firebaseManager.fetchQuestions()
    }
    
    // MARK: - func
    
    private func configureUI() {
        self.backgroundColor = .clear
        self.showsVerticalScrollIndicator = false
    }
    
    private func configureCollectionView() {
        register(QuestionListCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        delegate = self
        dataSource = self
    }
    
}

extension QuestionListCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let question = firebaseManager.question(at: indexPath.row)
        customDelegate?.questionCellTapped(question: question)
    }
}

extension QuestionListCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return firebaseManager.numberOfQuestions()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? QuestionListCollectionViewCell else { return UICollectionViewCell() }
        
        let question = firebaseManager.question(at: indexPath.row)
        cell.configure(with: question)
        return cell
    }
}

extension QuestionListCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = collectionView.frame.width
        let cellHeight: CGFloat = cellWidth - 260  // 적당한 높이를 설정합니다.
        return CGSize(width: cellWidth, height: cellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
