//
//  TagVC.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit

class TagVC: UIViewController {
    let tagCollectionView = TagCV()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tagCollectionView)
        
        tagCollectionView.snp.makeConstraints { make in
            // Add constraints as per your requirements
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
