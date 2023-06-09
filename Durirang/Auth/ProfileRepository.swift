//
//  ProfileRepository.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit
import Firebase

struct UserProfile: Codable {
    var uid: String
    var name: String
    var major: String
    var grade: Int
}

class ProfileRepository {
    func getUserProfile(completion: @escaping (_ profile: UserProfile) -> Void) {
        if let uid = Auth.auth().currentUser?.uid {
            let profileRef = Firestore.firestore().collection("users").document(uid)
            profileRef.getDocument { documentSnapshot, error in
                do {
                    if let profile = try documentSnapshot?.data(as: UserProfile.self) { completion(profile) }
                } catch {
                    print(error)
                }
            }
        }
    }
}
