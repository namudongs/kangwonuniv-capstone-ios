//
//  AuthManager.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

class AuthManager {
    static let shared = AuthManager()
    let db = Firestore.firestore()
    
    func createUser(email: String, pw: String, userName: String, major: String, grade: Int) {
        Auth.auth().createUser(withEmail: email, password: pw) {
            (result, error) in
            if error != nil {
                print("디버그: 사용자 생성 오류 \(error!)")
            } else {
                print("디버그: 사용자 생성 성공")
                let user = User(userID: result?.user.uid ?? "",
                                userName: userName,
                                userMajor: major,
                                userGrade: grade)
                let uid = result?.user.uid ?? ""
                do {
                    try self.db.collection("users").document(uid).setData(from: user)
                    print("디버그: 유저 데이터 저장 성공")
                } catch {
                    print("디버그: 유저 데이터 저장 실패 \(error)")
                }
            }
        }
    }
    
    func signIn(email: String, pw: String) {
        Auth.auth().signIn(withEmail: email, password: pw)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            print("디버그: 로그아웃 성공")
        } catch {
            print("디버그: 로그아웃 실패")
        }
    }
    
    func getUID() -> String? {
        if let uid = Auth.auth().currentUser?.uid {
            return uid
        } else {
            print("로그인되지 않았습니다")
            return nil
        }
    }
    
    func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
        if let uid = getUID() {
            db.collection("users").document(uid).getDocument { (documentSnapshot, error) in
                if let error = error { completion(.failure(error)); return }
                
                guard let document = documentSnapshot, document.exists, let userData = document.data() else { return }
                
                do {
                    let user = try Firestore.Decoder().decode(User.self, from: userData)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }
        } else { return }
    }
}
