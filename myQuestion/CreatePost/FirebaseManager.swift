//
//  FirebaseManager.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit
import Firebase

class FirebaseManager {
    static let shared = FirebaseManager()
    let db = Firestore.firestore()
    // 포스트 생성에 대한 파이어스토어 연동 필요
    
    func createPost(userID: String, userName: String, userMajor: String, userGrade: Int, title: String, text: String, category: String, like: Int, com: Int) {
        let post = Post( userID: userID,
                        userName: userName,
                        userMajor: userMajor,
                        userGrade: userGrade,
                        title: title,
                        text: text,
                        category: category,
                        timestamp: Timestamp().dateValue(),
                        like: like,
                        com: com )
        
        do {
            try db.collection("questions").document().setData(from: post)
            print("디버그: 포스트 생성 성공")
        } catch {
            print("디버그: 포스트 생성 오류 발생")
        }
    }
}
