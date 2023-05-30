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
    
    let firebase = FirebaseManager()
    
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
    
    var usernameTextField: UITextField! = {
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
                                     usernameTextField,
                                     signUpButton,
                                     signInButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.distribution = .fillEqually
        
        
        view.addSubview(stack)
        
        stack.setDimensions(height: 200, width: 300)
        stack.center(inView: view)
    }
    
    @objc func handleSignUp() {
        
    }
    
    
    @objc func handleSignIn() {
        
    }
    
}
