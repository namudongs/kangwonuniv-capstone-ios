//
//  Post.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import Foundation

struct Post: Codable, Equatable {
    let userID: String
    let userName: String
    let userMajor: String
    let userGrade: Int
    let title: String
    let text: String
    let category: String
    let timestamp: Date
    let like: Int
    let com: Int
}
