//
//  User.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import Foundation

struct User: Codable, Equatable {
//    @DocumentID var id: String?
    let userID: String
    let userName: String
    let userMajor: String
    let userGrade: Int
}
