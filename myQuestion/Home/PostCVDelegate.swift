//
//  PostCVDelegate.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit

protocol PostCVDelegate: AnyObject {
    
}

extension PostCV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let post = Firestore
    }
}

//extension PostCV: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//    }
//
//
//}

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
