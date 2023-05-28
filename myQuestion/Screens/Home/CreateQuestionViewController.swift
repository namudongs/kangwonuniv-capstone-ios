//
//  CreateQuestionViewController.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/26.
//

import UIKit

class CreateQuestionViewController: UIViewController {
    
    // MARK: - Property
    private var heartCount: Int? = 0
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "질문 제목"
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let questionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "질문 내용"
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
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Helper
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleTextField)
        view.addSubview(questionTextField)
        view.addSubview(addButton)
        
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            questionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addButton.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 20),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        guard let title = titleTextField.text,
              let questionText = questionTextField.text,
              titleTextField.text != "" && questionTextField.text != ""
        else {
            print("디버그: 모든 필드가 입력되지 않았습니다.")
            return
        }
        
        let questionID = UUID().uuidString
        let questionData: [String: Any] = [
            "questionID": questionID,
            "profileImage": "", // 프로필 이미지
            "title": title,
            "name": "유저이름",
            "timestamp": FirebaseManager.shared.timestamp,
            "questionText": questionText,
            "heartCount": 0,
            "commentCount": 0
        ]
        
        FirebaseManager.shared.addQuestion(questionData) { result in
            switch result {
            case .success(let questionID):
                print("디버그: 질문 등록 성공 질문: \(questionID)")
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print("디버그: 질문 등록 실패 에러내용: \(error)")
            }
        }
    }
}
