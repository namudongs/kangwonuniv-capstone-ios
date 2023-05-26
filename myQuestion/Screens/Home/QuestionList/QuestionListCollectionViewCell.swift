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
    
    private let questionLabel: UILabel = {
        let text: String = ""
        return CustomLabel(text: text, lineSpacing: 5, size: 13,
                           color: .black, numberOfLines: 3)
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
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        
    }
    
    func configure(with question: Question) {
        usernameLabel.text = question.name
        questionLabel.text = question.questionText
        heartCountLabel.text = question.heartCount
        commentCountLabel.text = question.commentCount
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: question.timestamp)
        let currentDate = Date()
        
        let timeInterval = currentDate.timeIntervalSince(question.timestamp)
        
        if timeInterval < 60 {
            timeLabel.text = "\(Int(timeInterval))초 전"
        } else if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            timeLabel.text = "\(minutes)분 전"
        } else if timeInterval < 86400 {
            let hours = Int(timeInterval / 3600)
            timeLabel.text = "\(hours)시간 전"
        } else {
            timeLabel.text = formattedDate
        }
    }
    
    // MARK: - Layout
    func configureCellLayout() {
        
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor,
                                paddingTop: 15, paddingLeft: 15)
        
        addSubview(usernameLabel)
        usernameLabel.anchor(left: profileImageView.rightAnchor, paddingLeft: 7)
        usernameLabel.centerY(inView: profileImageView)
        
        addSubview(dotView)
        dotView.anchor(left: usernameLabel.rightAnchor, paddingLeft: 7)
        dotView.centerY(inView: profileImageView)
        
        addSubview(timeLabel)
        timeLabel.anchor(left: dotView.rightAnchor, paddingLeft: 7)
        timeLabel.centerY(inView: profileImageView)
        
        addSubview(questionLabel)
        questionLabel.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 20, paddingBottom: 50, paddingRight: 20)
        
        addSubview(heartButton)
        heartButton.anchor(top: questionLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, paddingTop: -15, paddingLeft: 20, paddingBottom: 0)
        
        addSubview(heartCountLabel)
        heartCountLabel.anchor(left: heartButton.rightAnchor, paddingLeft: 1.5)
        heartCountLabel.centerY(inView: heartButton)
        
        addSubview(commentButton)
        commentButton.anchor(top: questionLabel.bottomAnchor, left: heartCountLabel.rightAnchor, bottom: bottomAnchor, paddingTop: -15, paddingLeft: 35, paddingBottom: 0)
        
        addSubview(commentCountLabel)
        commentCountLabel.anchor(left: commentButton.rightAnchor, paddingLeft: 2.5)
        commentCountLabel.centerY(inView: heartButton)
    }
}
