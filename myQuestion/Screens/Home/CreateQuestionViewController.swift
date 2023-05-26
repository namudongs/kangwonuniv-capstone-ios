//
//  CreateQuestionViewController.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/26.
//

import UIKit
import Firebase

class CreateQuestionViewController: UIViewController {
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이름"
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
    
    private let heartCountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "좋아요 수"
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let commentCountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "댓글 수"
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
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(nameTextField)
        view.addSubview(questionTextField)
        view.addSubview(heartCountTextField)
        view.addSubview(commentCountTextField)
        view.addSubview(addButton)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        heartCountTextField.translatesAutoresizingMaskIntoConstraints = false
        commentCountTextField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            questionTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            heartCountTextField.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 20),
            heartCountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heartCountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            commentCountTextField.topAnchor.constraint(equalTo: heartCountTextField.bottomAnchor, constant: 20),
            commentCountTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            commentCountTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            addButton.topAnchor.constraint(equalTo: commentCountTextField.bottomAnchor, constant: 40),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func addButtonTapped() {
        guard let name = nameTextField.text,
              let questionText = questionTextField.text,
              let heartCount = heartCountTextField.text,
              let commentCount = commentCountTextField.text else {
            return
        }
        
        let questionID = UUID().uuidString // or you can use your own method to generate ID
        let questionData: [String: Any] = [
            "questionID": questionID,
            "profileImage": "", // 프로필 이미지
            "name": name,
            "timestamp": Timestamp(),
            "questionText": questionText,
            "heartCount": heartCount,
            "commentCount": commentCount
        ]
        
        let db = Firestore.firestore()
        db.collection("questions").document(questionID).setData(questionData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added with ID: \(questionID)")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
