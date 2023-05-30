//
//  PostCV.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit

class PostCV: UICollectionView {

    weak var customDelegate: PostCVDelegate?

    private let reuseIdentifier = "PostCVCell"
    private let CVLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 30
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)

        return layout
    }()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: CVLayout)
        configureCV()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureCV() {
        register(PostCVCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        delegate = self
//        dataSource = self
    }
}


