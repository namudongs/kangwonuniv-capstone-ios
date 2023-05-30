//
//  TagCV.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit

class TagCV: UICollectionView {
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
    
    func getSelectedTag() -> String {
        if let selectedTag = self.selectedTag {
            return selectedTag
        } else {
            return "단과대학이 선택되지 않았습니다."
        }
    }
}
