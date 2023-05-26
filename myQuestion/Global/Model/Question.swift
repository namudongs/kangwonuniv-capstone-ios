//
//  Question.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/26.
//

import UIKit
import Firebase

public struct Question {

    let questionID: String
    let profileImage: String
    let name: String
    let timestamp: Date
    let questionText: String
    let heartCount: String
    let commentCount: String

    init(dictionary: [String: Any]) {
        self.questionID = dictionary["questionID"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        if let timestamp = dictionary["timestamp"] as? Timestamp {
            self.timestamp = timestamp.dateValue()
        } else {
            self.timestamp = Date()
        }
        self.questionText = dictionary["questionText"] as? String ?? ""
        self.heartCount = dictionary["heartCount"] as? String ?? ""
        self.commentCount = dictionary["commentCount"] as? String ?? ""
    }
}
