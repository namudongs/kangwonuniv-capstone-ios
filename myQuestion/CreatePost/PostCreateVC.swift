//
//  PostCreateVC.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit
import SnapKit

class PostCreateVC: UIViewController {
    // MARK: - Property
    private let tagCV = TagCV()
    private let firebase = FirebaseManager()
    private var heartCount: Int? = 0
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "제목을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "내용을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private var major = ""
    
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "단과대학을 입력하세요"
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("등록하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        searchTextField.addTarget(self, action: #selector(searchTags(_:)), for: .editingChanged)
        addButton.addTarget(self, action: #selector(returnMajor), for: .touchUpInside)
    }
    
    @objc func returnMajor() {
        major = tagCV.getSelectedTag()
        print(major)
    }
    
    func setUI() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [titleTextField, textField, searchTextField, tagCV, addButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.center.equalTo(self.view)
        }
        
        // Set a height constraint for the tagCollectionView.
        // tagCV.snp.makeConstraints { make in
        //     make.height.equalTo(50)  // Set an appropriate height for the collectionView.
        // }
    }
    
    @objc func searchTags(_ textField: UITextField) {
        guard let searchText = textField.text?.lowercased() else { return }
        let filteredTags = tagCV.temp.filter({ item in
            item.lowercased().contains(searchText)
        })
        if filteredTags.isEmpty == true {
            tagCV.tagList = tagCV.temp
            tagCV.reloadData()
        } else {
            tagCV.tagList = filteredTags
            tagCV.reloadData()
        }
    }
}
