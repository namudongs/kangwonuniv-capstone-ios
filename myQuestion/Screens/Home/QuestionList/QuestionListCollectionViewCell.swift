//
//  QuestionListCollectionViewCell.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit
final class QuestionListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        //        imageView.image = #imageLiteral(resourceName: "profileTest")
        imageView.setDimensions(height: 30, width: 30)
        imageView.layer.cornerRadius = 30/2
        imageView.backgroundColor = .gray.withAlphaComponent(0.2)
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        return CustomLabel(text: "", boldSize: 11,
                           color: .black.withAlphaComponent(0.9))
    }()
    
    private let dotView: UIView = {
        let view = UIView()
        view.setDimensions(height: 3, width: 3)
        view.layer.cornerRadius = 3/2
        view.backgroundColor = .black.withAlphaComponent(0.2)
        return view
    }()
    
    private let timeLabel: UILabel = {
        return CustomLabel(text: "", boldSize: 10, color: .black.withAlphaComponent(0.5))
    }()
    
    private let questionTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 13)
        
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1 // Dynamic height
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    
    private let heartButton: UIButton = {
        return CustomButton(color: .red,
                            systemImage: "heart.fill")
    }()
    
    private let heartCountLabel: UILabel = {
        return CustomLabel(text: "", boldSize: 10, color: .black)
    }()
    
    private let commentButton: UIButton = {
        return CustomButton(color: .gray.withAlphaComponent(0.2),
                            systemImage: "message.fill")
    }()
    
    private let commentCountLabel: UILabel = {
        return CustomLabel(text: "", boldSize: 10, color: .black)
    }()
    
    
    // MARK: - 생성자
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        configureCellLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 헬퍼
    func setUp() {
        
        backgroundColor = .systemGray6.withAlphaComponent(0.5)
//        self.layer.cornerRadius = 30
//        self.clipsToBounds = true
        
    }
    
    func configure(with question: Question) {
        usernameLabel.text = question.name
        questionTitleLabel.text = question.title
        questionLabel.text = question.questionText
        heartCountLabel.text = String(question.heartCount)
        commentCountLabel.text = String(question.commentCount)
        
        let timeInterval = Date().timeIntervalSince(question.timestamp)
        let timeText = formatTimeInterval(timeInterval)
        timeLabel.text = timeText
    }

    private func formatTimeInterval(_ timeInterval: TimeInterval) -> String {
        switch timeInterval {
        case 0..<60:
            return "\(Int(timeInterval))초 전"
        case 60..<3600:
            return "\(Int(timeInterval / 60))분 전"
        case 3600..<86400:
            return "\(Int(timeInterval / 3600))시간 전"
        case 86400..<2592000:
            return "\(Int(timeInterval / 86400))일 전"
        case 2592000..<31536000:
            return "\(Int(timeInterval / 2592000))달 전"
        default:
            return "\(Int(timeInterval / 31536000))년 전"
        }
    }
    
    // MARK: - Layout
    func configureCellLayout() {
        
        addSubview(profileImageView)
        addSubview(usernameLabel)
        addSubview(dotView)
        addSubview(timeLabel)
        addSubview(questionTitleLabel)
        addSubview(questionLabel)
        let heartStack = UIStackView(arrangedSubviews: [heartButton, heartCountLabel])
        let commentStack = UIStackView(arrangedSubviews: [commentButton, commentCountLabel])
        
        heartStack.axis = .horizontal
        heartStack.spacing = 5
        heartStack.distribution = .equalSpacing
        
        commentStack.axis = .horizontal
        commentStack.spacing = 5
        commentStack.distribution = .equalSpacing
        
        addSubview(heartStack)
        addSubview(commentStack)
        
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 15, paddingLeft: 15)
        
        usernameLabel.anchor(left: profileImageView.rightAnchor, paddingLeft: 7)
        usernameLabel.centerY(inView: profileImageView)
        
        dotView.anchor(left: usernameLabel.rightAnchor, paddingLeft: 7)
        dotView.centerY(inView: profileImageView)
        
        timeLabel.anchor(left: dotView.rightAnchor, paddingLeft: 7)
        timeLabel.centerY(inView: profileImageView)
                
        questionTitleLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: questionLabel.topAnchor, right: rightAnchor, paddingTop: 5, paddingLeft: 15, paddingRight: 20)

        questionLabel.anchor(top: questionTitleLabel.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15, paddingRight: 20)
        
        heartStack.anchor(top: questionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: 7, paddingLeft: 15, paddingBottom: 5, paddingRight: 15)
        commentStack.anchor(top: questionLabel.bottomAnchor, left: heartStack.rightAnchor, bottom: bottomAnchor, paddingTop: 7, paddingLeft: 15, paddingBottom: 5)
        
    }
}
