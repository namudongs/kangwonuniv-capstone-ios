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
        
        FirebaseManager.shared.dataUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.reloadData()
            }
        }
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

protocol PostCVDelegate: AnyObject {
    func postCellTapped(post: Post)
}

extension PostCV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let post = Firestore
    }
}

extension PostCV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        var cellHeight: CGFloat = cellWidth / 3
        
        if screenHeight >= 896 { // 예를 들어, iPhone 11 Pro Max, iPhone 13 Pro Max 등의 높이인 896pt 이상일 경우
                    cellHeight = (cellWidth / 3) - 10 // 맥스 모델에 맞는 높이
                } else {
                    cellHeight = cellWidth / 3 // 그 외 모델에 맞는 높이
                }
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}

