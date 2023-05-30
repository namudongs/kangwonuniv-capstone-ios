//
//  CustomLabel.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/26.
//

import UIKit

class CustomLabel: UILabel {
    
    // MARK: - Initial
    init(text: String, size: CGFloat, color: UIColor!) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.systemFont(ofSize: size)
        self.textColor = color
        self.sizeToFit()
    }
    
    // MARK: - Bold
    init(text: String, boldSize: CGFloat, color: UIColor!) {
        super.init(frame: .zero)
        self.text = text
        self.font = UIFont.boldSystemFont(ofSize: boldSize)
        self.textColor = color
        self.sizeToFit()
    }
    
    // MARK: - Print Long Text
    init(text: String, lineSpacing: CGFloat, size: CGFloat, color: UIColor!, numberOfLines: Int) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: size)
        self.textColor = color
        let attributedText = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributedText.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.length))
        self.attributedText = attributedText
        self.numberOfLines = numberOfLines
        self.lineBreakMode = .byTruncatingTail // 말줄임표 설정
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
