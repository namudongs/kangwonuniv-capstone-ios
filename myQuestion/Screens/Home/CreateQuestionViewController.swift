//
//  CreateQuestionViewController.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/26.
//

import UIKit
import Firebase

class CreateQuestionViewController: UIViewController {
    
    // MARK: - Property
    private var heartCount: Int? = 0
    
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
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("하트버튼", for: .normal)
        button.backgroundColor = .systemRed.withAlphaComponent(0.6)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
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
    
    override func viewDidAppear(_ animated: Bool) {
        heartCount = 0
    }
    
    // MARK: - Helper
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(nameTextField)
        view.addSubview(questionTextField)
        view.addSubview(heartButton)
        view.addSubview(addButton)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            questionTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 20),
            questionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            heartButton.topAnchor.constraint(equalTo: questionTextField.bottomAnchor, constant: 20),
            heartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            heartButton.heightAnchor.constraint(equalToConstant: 50),
            
            addButton.topAnchor.constraint(equalTo: heartButton.bottomAnchor, constant: 40),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        NSLayoutConstraint.activate(constraints)
        heartButton.addTarget(self, action: #selector(heartButtonTapped), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    }
    
    @objc private func heartButtonTapped() {
        self.heartCount! += 1
        print("디버그: \(Int(heartCount!))")
    }
    
    @objc private func addButtonTapped() {
        guard nameTextField.text != "" && questionTextField.text != ""
        else {
            print("디버그: 모든 필드가 입력되지 않았습니다.")
            return }
        
        guard let name = nameTextField.text,
              let questionText = questionTextField.text,
              let heartCount = heartCount
        else { return }
        
        let questionID = UUID().uuidString // or you can use your own method to generate ID
        let questionData: [String: Any] = [
            "questionID": questionID,
            "profileImage": "", // 프로필 이미지
            "name": name,
            "timestamp": Timestamp(),
            "questionText": questionText,
            "heartCount": heartCount,
            "commentCount": 0
        ]
        print("디버그: \(Int(heartCount))")
        
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
