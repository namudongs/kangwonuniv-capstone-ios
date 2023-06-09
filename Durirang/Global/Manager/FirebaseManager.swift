//  FirebaseManager.swift
//  myQuestion
//  Created by namdghyun on 2023/05/25.

import Foundation
import Firebase
import FirebaseFirestore

extension Timestamp {
    func convertToDate() -> Date {
        return dateValue()
    }
}

class FirebaseManager {
    let timestamp = Timestamp()
    var users = [User]()
    var questions = [Question]()
    var dataUpdated: (() -> Void)?
    
    private var db: Firestore {
        return Firestore.firestore()
    }
    
    private let questionCollection = "questions"
    private let answerCollection = "answers"
    
    func updateHeartCount(_ questionID: String, _ heartCount: Int, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(questionCollection).document(questionID).updateData(["heartCount" : heartCount]) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // MARK: - Questions
    func addQuestion(_ questionData: [String: Any], completion: @escaping (Result<String, Error>) -> Void) {
        let questionID = UUID().uuidString
        var questionData = questionData
        questionData["questionID"] = questionID

        db.collection(questionCollection).document(questionID).setData(questionData) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(questionID))
            }
        }
    }
    
    func deleteQuestion(_ questionID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        db.collection(questionCollection).document(questionID).delete { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func fetchQuestions() {
        db.collection(questionCollection)
            .order(by: "timestamp", descending: true)
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
    
    // MARK: - Answers
    func addAnswer(_ questionID: String, _ commentCount: Int, _ answerData: [String: Any], completion: @escaping (Result<Void, Error>) -> Void) {
        let questionDocument = db.collection("questions").document(questionID)
        questionDocument.updateData(["commentCount" : commentCount]) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            let answerID = answerData["answerID"] as! String
            questionDocument.collection("answers").document(answerID).setData(answerData) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    func deleteAnswers(_ questionID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let answersCollection = db.collection("questions").document(questionID).collection("answers")
        answersCollection.getDocuments { (snapshot, err) in
            guard let snapshot = snapshot else {
                completion(.failure(err!))
                return
            }

            guard !snapshot.isEmpty else {
                completion(.success(()))
                return
            }

            for document in snapshot.documents {
                answersCollection.document(document.documentID).delete { err in
                    if let err = err {
                        completion(.failure(err))
                        return
                    }
                }
            }
            completion(.success(()))
        }
    }

    
    func fetchAnswers(_ questionID: String, completion: @escaping (Result<String, Error>) -> Void) {
        db.collection(questionCollection).document(questionID).collection(answerCollection)
            .order(by: "timestamp", descending: false)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    completion(.failure(err))
                } else {
                    var answersText = ""
                    for document in querySnapshot!.documents {
                        let answerData = document.data()
                        if let answerText = answerData["answerText"] as? String {
                            answersText += answerText + "\n\n"
                        }
                    }
                    completion(.success(answersText))
                }
            }
    }
    
    // MARK: - Auth
    
    func checkLoginStatus(completion: @escaping (Bool) -> Void) {
        if Auth.auth().currentUser != nil {
            completion(true)
        } else {
            completion(false)
        }
    }
        
    func addUserdata(_ userData: [String : Any], _ uid: String, completion: @escaping (Result<String, Error>) -> Void) {
        db.collection("Users").document().setData(userData) { err in
            if let err = err {
                completion(.failure(err))
            } else {
                completion(.success(uid))
            }
        }
    }
    
    func signUp(_ email: String, _ pw: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pw) { authResult, error in
            if let authResult = authResult {
                completion(.success(authResult.user.uid))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func signIn(_ email: String, _ pw: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pw) { authResult, error in
            if let authResult = authResult {
                completion(.success(authResult.user.uid))
            } else if let error = error {
                completion(.failure(error))
            }
        }
    }
    
    func logout(completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(.success(()))
        } catch let signOutError {
            completion(.failure(signOutError))
        }
    }

    // MARK: - etc
    func numberOfQuestions() -> Int {
        return questions.count
    }
    
    func question(at index: Int) -> Question {
        return questions[index]
    }
}
