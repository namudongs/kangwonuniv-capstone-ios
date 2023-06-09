//
//  MainViewController.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    let firebase = FirebaseManager()
    
    // MARK: - Property
    private let homeTab: UINavigationController = {
        let controller = UINavigationController(rootViewController: HomeViewController())
        controller.tabBarItem.image = UIImage(systemName: "house")
        controller.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        controller.title = "홈"
        return controller
    }()
    
    private let timerTab: UINavigationController = {
        let controller = UINavigationController(rootViewController: TimerViewController())
        controller.tabBarItem.image = UIImage(systemName: "timer")
        controller.tabBarItem.selectedImage = UIImage(systemName: "timer.fill")
        controller.title = "타이머"
        return controller
    }()
    
    private let postQuestionTab: UINavigationController = {
        let controller = UINavigationController(rootViewController: PostQuestionViewController())
        controller.tabBarItem.image = UIImage(systemName: "xmark.circle")
        controller.tabBarItem.selectedImage = UIImage(systemName: "xmark.circle.fill")
        controller.title = "기능 미정"
        return controller
    }()
    
    private let myPageTab: UINavigationController = {
        let controller = UINavigationController(rootViewController: MyPageViewController())
        controller.tabBarItem.image = UIImage(systemName: "person")
        controller.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        controller.title = "마이페이지"
        return controller
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLogin()
        configureTabBar()
        configureUI()
        
        setViewControllers([homeTab, timerTab, postQuestionTab, myPageTab], animated: true)
    }
    
    func checkLogin() {
        firebase.checkLoginStatus { [weak self] isLoggedIn in
            if isLoggedIn {
            } else {
                DispatchQueue.main.async {
                    let signInViewController = SignInViewController()
                    signInViewController.modalPresentationStyle = .fullScreen
                    self?.present(signInViewController, animated: false, completion: nil)
                }
            }
        }
    }
    
    func configureTabBar() {
        tabBar.tintColor = .black
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .systemBackground
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    func configureUI() {
        view.backgroundColor = .gray
    }
}
