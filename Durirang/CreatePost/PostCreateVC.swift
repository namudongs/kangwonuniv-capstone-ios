//
//  PostCreateVC.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit
import SnapKit
import Then

class PostCreateVC: UIViewController {
    // MARK: - Property
    var user: User?
    private let tagCV = TagCV()
    private let firebase = FirebaseManager()
    private var heartCount: Int? = 0
    private var major = ""
    
    private let titleTextField = UITextField().then {
        $0.placeholder = "제목을 입력하세요"
        $0.borderStyle = .roundedRect
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    
    private let textField = UITextField().then {
        $0.placeholder = "내용을 입력하세요"
        $0.borderStyle = .roundedRect
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    
    private let searchTextField = UITextField().then {
        $0.placeholder = "단과대학을 입력하세요"
        $0.borderStyle = .roundedRect
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftViewMode = .always
    }
    
    private let addButton = UIButton().then {
        $0.setTitle("등록하기", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 8
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        searchTextField.addTarget(self, action: #selector(searchTags(_:)), for: .editingChanged)
        addButton.addTarget(self, action: #selector(createPost), for: .touchUpInside)
    }
    
    func setUP() {
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [
            titleTextField, textField, searchTextField, tagCV, addButton])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 10
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.center.equalToSuperview()
        }
    }
    // MARK: - Helpers
    
    @objc func createPost() {
        guard let user = user else { print("유저 정보를 가져올 수 없습니다"); return }
        guard let title = titleTextField.text, let text = textField.text else { return }
              
        FirebaseManager.shared.createPost(userID: user.userID,
                                          userName: user.userName,
                                          userMajor: user.userMajor,
                                          userGrade: user.userGrade,
//                                          postID:
                                          title: title,
                                          text: text,
                                          category: tagCV.getSelectedTag(),
                                          like: 0,
                                          com: 0)
        
        // 포스트 생성 성공 시 뷰컨트롤러 이동
    }
    
    @objc func searchTags(_ textField: UITextField) {
        guard let searchText = textField.text?.lowercased() else { return }
        let filteredTags = tagCV.temp.filter { $0.lowercased().contains(searchText) }
        tagCV.tagList = filteredTags.isEmpty ? tagCV.temp : filteredTags
        tagCV.reloadData()
    }
}
