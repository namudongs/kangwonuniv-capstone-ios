//
//  TagCVDelegate.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/31.
//

import UIKit

extension TagCV: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTag = tagList[indexPath.item]
        
        if selectedTag == self.selectedTag {
            self.selectedTag = nil
        } else {
            self.selectedTag = selectedTag
        }
        
        collectionView.reloadData()
    }
}

extension TagCV: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        
        let tag = tagList[indexPath.item]
        let isSelected = tag == selectedTag
        cell.configure(with: tag, isSelected: isSelected)
        
        return cell
    }
}

extension TagCV: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = tagList[indexPath.item]
        label.sizeToFit()
        
        let size = label.frame.size
        return CGSize(width: size.width + 10, height: size.height + 10)
    }
}
