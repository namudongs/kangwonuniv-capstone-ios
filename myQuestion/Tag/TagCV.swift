//
//  TagCV.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit

class TagCV: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var tagList = [String]()
    var temp = [String]()
    var selectedTag: String?
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        dataSource = self
        delegate = self
        register(TagCell.self, forCellWithReuseIdentifier: "TagCell")
        backgroundColor = .white
        
        temp = ["간호대학", "경영대학", "농업생명과학대학", "동물생명과학대학", "문화예술·공과대학", "사범대학", "사회과학대학", "산림환경과학대학", "수의과대학", "약학대학", "의과대학", "의생명과학대학", "인문대학", "자연과학대학", "IT대학", "미래융합가상학과", "춘천자유전공학부", "연계전공"]
        
        tagList = temp
        
        reloadData()
    }
    
    // MARK: - UICollectionViewDelegate
    
    //    셀을 선택했을 때 호출되는 메서드입니다.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTag = tagList[indexPath.item]
        
        if selectedTag == self.selectedTag {
            self.selectedTag = nil
        } else {
            self.selectedTag = selectedTag
        }
        
        collectionView.reloadData()
    }
    
    func getSelectedTag() -> String {
        if let selectedTag = self.selectedTag {
            return selectedTag
        } else {
            return "단과대학이 선택되지 않았습니다."
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    // UICollectionView의 섹션 수를 결정하는 함수입니다. 여기서는 섹션이 1개라고 명시되어 있습니다.
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // UICollectionView의 섹션당 항목 수를 결정하는 함수입니다. tagList 배열의 요소 수에 따라 항목 수가 결정됩니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagList.count
    }
    
    // IndexPath 위치에 해당하는 셀을 설정하고 반환하는 함수입니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
        
        let tag = tagList[indexPath.item]
        let isSelected = tag == selectedTag
        cell.configure(with: tag, isSelected: isSelected)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.text = tagList[indexPath.item]
        label.sizeToFit()
        
        let size = label.frame.size
        return CGSize(width: size.width + 10, height: size.height + 10)
    }
}


