//
//  SignInContorller.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    var emailTextField: UITextField! = {
        let tf = UITextField()
        tf.placeholder = "이메일을 입력하세요"
        tf.borderStyle = .none
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.black.withAlphaComponent(0.3).cgColor
        tf.layer.cornerRadius = 5.0
        
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
        
        let pv = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: tf.frame.height))
        tf.leftView = pv
        tf.leftViewMode = .always
        
        return tf
    }()
    
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
        signInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }
    
    func setUpUI() {
        let stack = UIStackView(arrangedSubviews:
                                    [emailTextField,
                                     passwordTextField,
                                     signUpButton,
                                     signInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        
        view.addSubview(stack)
        
        // Set constraints for the stack view
        stack.setDimensions(height: 200, width: 300)
        stack.center(inView: view)
    }
    
    @objc func handleSignUp() {
        let temp: String = emailTextField.text!.description
        let email: String = temp + "@kangwon.ac.kr"
        let pw: String = emailTextField.text!.description
        
        Auth.auth().createUser(withEmail: email, password: pw) { authResult, error in
            if authResult != nil {
                print("디버그: 등록 성공!")
            } else {
                print("디버그: 등록 실패\n에러내용:\(error.debugDescription)")
            }
        }
    }
    
    @objc func handleSignIn() {
        
        let temp: String = emailTextField.text!.description
        let email: String = temp + "@kangwon.ac.kr"
        let pw: String = emailTextField.text!.description
        
        Auth.auth().signIn(withEmail: email, password: pw) { authResult, error in
            if authResult != nil {
                print("디버그: 로그인 성공!")
                let mainViewController = HomeViewController()
                let navigationController = UINavigationController(rootViewController: mainViewController)
                navigationController.modalPresentationStyle = .fullScreen
            } else {
                print("디버그: 로그인 실패\n에러내용:\(error.debugDescription)")
            }
        }
        
//        로그인 성공 시 MainViewController로 이동
//        let mainViewController = MainViewController()
//        let navigationController = UINavigationController(rootViewController: mainViewController)
//        navigationController.modalPresentationStyle = .fullScreen
//        strongSelf.present(navigationController, animated: true, completion: nil)
        
    }
    
    func appendDomainToEmail(_ email: String, domain: String = "@kangwon.ac.kr") -> String {
        return email + domain
    }
    
}
