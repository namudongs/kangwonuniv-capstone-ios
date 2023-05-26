import UIKit
import Firebase

class QuestionDetailViewController: UIViewController {
    var question: Question?
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(questionLabel)
        view.addSubview(deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteQuestion), for: .touchUpInside)
        setupLayout()
        
        updateUI()
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            deleteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 20),
            deleteButton.widthAnchor.constraint(equalToConstant: 200),
            deleteButton.heightAnchor.constraint(equalToConstant: 50)
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
            Question: \(question.questionText)
            Heart Count: \(question.heartCount)
            Comment Count: \(question.commentCount)
            Time: \(formattedDate)
            Question ID: \(question.questionID)
            
            """
    }
    
    @objc private func deleteQuestion() {
        guard let questionId = question?.questionID else { return }
        let db = Firestore.firestore()

        db.collection("questions").document(questionId).delete { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
