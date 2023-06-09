//
//  TimerViewController.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit

class TimerViewController: UIViewController {
    
    private lazy var collectionView: QuestionListCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = QuestionListCollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
//
//        view.addSubview(collectionView)
//        collectionView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor)
    }

}
