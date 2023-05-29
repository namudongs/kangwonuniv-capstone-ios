//
//  User.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/29.
//

import Foundation
import Firebase

public struct User {
    
    let email: String
    let profileImage: String
    let name: String
    let timestamp: Date
    
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        if let timestamp = dictionary["timestamp"] as? Timestamp {
            self.timestamp = timestamp.dateValue()
        } else {
            self.timestamp = Date()
        }
    }
}
