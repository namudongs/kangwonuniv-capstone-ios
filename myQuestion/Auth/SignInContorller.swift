//
//  SignInContorller.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit
import SnapKit
import Then

class SignInViewController: UIViewController {
    
    // MARK: - Property
    private let tagCV = TagCV()
    private let gradeCV = TagCV()
    
    var emailTextField = UITextField().then {
        $0.placeholder = "이메일을 입력하세요"
        $0.borderStyle = .none
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        $0.layer.cornerRadius = 5.0
        $0.autocapitalizationType = .none
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftView = pv
        $0.leftViewMode = .always
    }
    
    var passwordTextField = UITextField().then {
        $0.placeholder = "비밀번호를 입력하세요"
        $0.borderStyle = .none
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        $0.layer.cornerRadius = 5.0
        $0.isSecureTextEntry = true
        $0.autocapitalizationType = .none
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftView = pv
        $0.leftViewMode = .always
    }
    
    var userNameTextField = UITextField().then {
        $0.placeholder = "닉네임을 입력하세요"
        $0.borderStyle = .none
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        $0.layer.cornerRadius = 5.0
        $0.autocapitalizationType = .none
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftView = pv
        $0.leftViewMode = .always
    }
    
    @objc private let searchTextField = UITextField().then {
        $0.placeholder = "단과대학을 입력하세요"
        $0.borderStyle = .none
        $0.layer.borderWidth = 1.0
        $0.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        $0.layer.cornerRadius = 5.0
        $0.autocapitalizationType = .none
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: $0.frame.height))
        $0.leftView = pv
        $0.leftViewMode = .always
    }
        
    var signUpButton = UIButton().then {
        $0.setTitle("등록하기", for: .normal)
        $0.backgroundColor = .systemBlue
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    var signInButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 5
        $0.layer.masksToBounds = true
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
        searchTextField.addTarget(self, action: #selector(searchTags(_:)), for: .editingChanged)
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    func setUp() {
        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, userNameTextField, searchTextField, tagCV, gradeCV, signUpButton, signInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        gradeCV.tagList = ["1학년", "2학년", "3학년", "4학년"]
        view.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.height.equalTo(500)
            make.width.equalTo(300)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Helpers
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
                // 이 데이터를 가지고 다음 뷰로 이동 \(MainTabBar)
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
