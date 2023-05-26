//
//  FirebaseManager.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import Combine
import Foundation

import Firebase
import FirebaseFirestore

extension Timestamp {
    func convertToDate() -> Date {
        return dateValue()
    }
}

class FirebaseManager {
    static let shared = FirebaseManager()
    var questions = [Question]()
    var dataUpdated: (() -> Void)?
    
    func fetchQuestions() {
        let db = Firestore.firestore()
        
        db.collection("questions")
            .order(by: "timestamp", descending: true) // 시간순으로 정렬 (내림차순)
            .addSnapshotListener { [weak self] (querySnapshot, err) in
                guard let self = self else { return }
                if let err = err {
                    print("질문을 가져오지 못했습니다\n에러내용: \(err)")
                } else {
                    self.questions.removeAll()
                    for document in querySnapshot!.documents {
                        let questionData = Question(dictionary: document.data())
                        self.questions.append(questionData)
                    }
                    self.dataUpdated?()
                }
            }
    }

    
    func numberOfQuestions() -> Int {
        return questions.count
    }
    
    func question(at index: Int) -> Question {
        return questions[index]
    }
}

