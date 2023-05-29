//
//  MypageViewController.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let firebase = FirebaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUp()
    }
    
    var logOutButton: UIButton! = {
        let bt = UIButton()
        bt.setTitle("로그아웃", for: .normal)
        bt.backgroundColor = .systemRed
        bt.layer.cornerRadius = 5
        bt.layer.masksToBounds = true
        
        return bt
    }()
    
    func setUp() {
        view.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ]
        
        NSLayoutConstraint.activate(constraints)
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    @objc func logOut() {
        firebase.logout { result in
            switch result {
            case .success():
                print("디버그: 로그아웃 성공")
                //
                let signInViewController = SignInViewController()
                signInViewController.modalPresentationStyle = .fullScreen
                self.present(signInViewController, animated: true)
            case .failure(let err):
                print("디버그: 로그아웃 실패 \(err)")
            }
        }
    }
}
