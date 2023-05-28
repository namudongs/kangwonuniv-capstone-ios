import UIKit
import Firebase

class QuestionDetailViewController: UIViewController {
    
    // MARK: - Property
    var question: Question?
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("하트버튼", for: .normal)
        button.backgroundColor = .systemRed.withAlphaComponent(0.6)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("삭제하기", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    private let answerTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "답변 내용"
        textField.borderStyle = .roundedRect
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        return textField
    }()
    
    private let answerAddButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("답변하기", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let showAnswerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "테스트"
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(questionLabel)
        view.addSubview(heartButton)
        view.addSubview(deleteButton)
        view.addSubview(answerTextField)
        view.addSubview(answerAddButton)
        view.addSubview(showAnswerLabel)
        
        heartButton.addTarget(self, action: #selector(heartTapped), for: .touchUpInside)
        deleteButton.addTarget(self, action: #selector(deleteQuestion), for: .touchUpInside)
        answerAddButton.addTarget(self, action: #selector(addAnswer), for: .touchUpInside)
        setupLayout()
        
        updateUI()
    }
    
    // MARK: - Helpers
    private func setupLayout() {
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            heartButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            heartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            heartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            heartButton.heightAnchor.constraint(equalToConstant: 50),
            
            deleteButton.topAnchor.constraint(equalTo: heartButton.bottomAnchor, constant: 20),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 50),
            
            answerTextField.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 40),
            answerTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            answerAddButton.topAnchor.constraint(equalTo: answerTextField.bottomAnchor, constant: 20),
            answerAddButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            answerAddButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            answerAddButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            answerAddButton.heightAnchor.constraint(equalToConstant: 50),
            
            showAnswerLabel.topAnchor.constraint(equalTo: answerAddButton.bottomAnchor, constant: 40),
            showAnswerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showAnswerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            showAnswerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
        ])
    }
    
    private func updateUI() {
        view.backgroundColor = .white
        guard let question = question else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: question.timestamp)
        
        questionLabel.text = """
            Username: \(question.name)
            QuestionTitle: \(question.title)
            Question: \(question.questionText)
            Heart Count: \(question.heartCount)
            Comment Count: \(question.commentCount)
            Time: \(formattedDate)
            Question ID: \(question.questionID)
            """
        showAnswers()
    }
    
    @objc private func heartTapped() {
        guard var heartCount = question?.heartCount, let questionID = question?.questionID else { return }
        heartCount += 1
        print(heartCount)
        
        let db = Firestore.firestore()
        db.collection("questions").document(questionID).updateData(["heartCount" : heartCount]) { err in
            if let err = err {
                print("디버그: 하트카운트 증가 실패: \(err)")
            } else {
                print("디버그: 하트카운트 증가 성공")
            }
        }
        
    }
    
    @objc private func deleteQuestion() {
        guard let questionId = question?.questionID else { return }
        let db = Firestore.firestore()

        // First, delete all the answers
        deleteAnswers(in: questionId) { err in
            if let err = err {
                print("디버그: 질문 삭제 실패: \(err)")
                return
            }

            // Then delete the question itself
            db.collection("questions").document(questionId).delete { err in
                if let err = err {
                    print("디버그: 답변 삭제 실패: \(err)")
                } else {
                    print("디버그: 질문과 답변이 성공적으로 삭제됐습니다.")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }

    
    @objc private func addAnswer() {
        guard let questionId = question?.questionID else { return }
        guard var commentCount = question?.commentCount else { return }
        guard let answertext = answerTextField.text else { return }
        
        commentCount += 1
        print(commentCount)
        
        let db = Firestore.firestore()
        
        let answerID = UUID().uuidString
        let answerData: [String: Any] = [
            "answerID": answerID,
            "profileImage": "", // 프로필 이미지
            "title": "답변제목",
            "name": "유저이름",
            "timestamp": Timestamp(),
            "answerText": answertext,
            "heartCount": 0,
            "commentCount": 0
        ]
        
        db.collection("questions").document(questionId).updateData(["commentCount" : commentCount]) { error in
            if let error = error {
                print("디버그: 코멘트 증가 실패 \(error)")
            } else {
                print("디버그: 질문에 코멘트 증가 성공, 질문: \(questionId), 코멘트: \(commentCount)")
//                self.navigationController?.popViewController(animated: true)
            }
        }
        
        db.collection("questions").document(questionId).collection("answers").document(answerID).setData(answerData) { error in
            if let error = error {
                print("디버그: 질문에 답변 등록 실패: \(error)")
            } else {
                print("디버그: 질문에 답변 등록 성공: 질문: \(questionId) 답변: \(answerID)")
                self.updateUI()
//                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func deleteAnswers(in questionId: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()

        db.collection("questions").document(questionId).collection("answers").getDocuments { (snapshot, err) in
            guard let snapshot = snapshot else {
                completion(err)
                return
            }

            guard !snapshot.isEmpty else {
                completion(nil)
                return
            }

            for document in snapshot.documents {
                db.collection("questions").document(questionId).collection("answers").document(document.documentID).delete { err in
                    if let err = err {
                        completion(err)
                        return
                    }
                }
            }
            completion(nil)
        }
    }
    
    private func showAnswers() {
        guard let questionId = question?.questionID else { return }
        let db = Firestore.firestore()

        db.collection("questions").document(questionId).collection("answers")
            .order(by: "timestamp", descending: false)
            .getDocuments { (querySnapshot, err) in
                if let err = err {
                    print("디버그: 답변을 불러오는 데에 오류가 발생했습니다. \(err)")
                } else {
                    var answersText = ""
                    for document in querySnapshot!.documents {
                        let answerData = document.data()
                        if let answerText = answerData["answerText"] as? String {
                            answersText += answerText + "\n\n"
                        }
                    }
                    self.showAnswerLabel.text = answersText
                }
            }
    }
}
