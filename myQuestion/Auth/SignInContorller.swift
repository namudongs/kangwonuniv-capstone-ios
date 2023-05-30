//
//  SignInContorller.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit

class SignInViewController: UIViewController {
    
    var userName = ""
    var userInfoLabel: UILabel! = {
        let label = UILabel()
        
        return label
    }()
    
    var emailTextField: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "이메일을 입력하세요"
        tf.borderStyle = .none
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        tf.layer.cornerRadius = 5.0
        tf.autocapitalizationType = .none
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = pv
        tf.leftViewMode = .always
        
        return tf
    }()
    
    var passwordTextField: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "비밀번호를 입력하세요"
        tf.borderStyle = .none
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        tf.layer.cornerRadius = 5.0
        tf.isSecureTextEntry = true
        tf.autocapitalizationType = .none
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = pv
        tf.leftViewMode = .always
        
        return tf
    }()
    
    var userNameTextField: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력하세요"
        tf.borderStyle = .none
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        tf.layer.cornerRadius = 5.0
        tf.autocapitalizationType = .none
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = pv
        tf.leftViewMode = .always
        
        return tf
    }()
    
    @objc private let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "단과대학을 입력하세요"
        tf.borderStyle = .none
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        tf.layer.cornerRadius = 5.0
        tf.autocapitalizationType = .none
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = pv
        tf.leftViewMode = .always
        
        return tf
    }()
    
    private let tagCV = TagCV()
    
    private let gradeCV = TagCV()
    
    var signUpButton: UIButton! = {
        let bt = UIButton()
        bt.setTitle("등록하기", for: .normal)
        bt.backgroundColor = .systemBlue
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        
        return bt
    }()
    
    var signInButton: UIButton! = {
        let bt = UIButton()
        bt.setTitle("로그인하기", for: .normal)
        bt.backgroundColor = .systemGreen
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        
        return bt
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
        searchTextField.addTarget(self, action: #selector(searchTags(_:)), for: .editingChanged)
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    func setUpUI() {
        let stack = UIStackView(arrangedSubviews:
                                    [emailTextField,
                                     passwordTextField,
                                     userNameTextField,
                                     searchTextField,
                                     tagCV,
                                     gradeCV,
                                     signUpButton,
                                     signInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        gradeCV.tagList = ["1학년", "2학년", "3학년", "4학년"]
        view.addSubview(stack)
        
        stack.setDimensions(height: 500, width: 300)
        stack.center(inView: view)
    }
    
    @objc func handleSignUp() {
        let email = emailTextField.text!
        let pw = passwordTextField.text!
        let userName = userNameTextField.text!
        let major = tagCV.getSelectedTag()
        let grade: Int
        
        switch gradeCV.getSelectedTag() {
        case "1학년":
            grade = 1
        case "2학년":
            grade = 2
        case "3학년":
            grade = 3
        case "4학년":
            grade = 4
        default:
            grade = 0
        }
        
        AuthManager.shared.createUser(email: email, pw: pw, userName: userName, major: major, grade: grade)
    }
    
    
    @objc func handleSignIn() {
        let email = emailTextField.text!
        let pw = passwordTextField.text!
        
        AuthManager.shared.signIn(email: email, pw: pw)
        print("로그인 완료")
        
        AuthManager.shared.getUserData { result in
            switch result {
            case .success(let user):
                print("사용자 데이터: \(user)")
            case .failure(let error):
                print("사용자 데이터를 가져오는 중 오류 발생 \(error)")
            }
        }
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
