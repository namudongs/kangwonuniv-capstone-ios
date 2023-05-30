//
//  TagCell.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/30.
//

import UIKit
import Then

class TagCell: UICollectionViewCell {
    
    private let tagLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tagLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        tagLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    func configure(with text: String, isSelected: Bool) {
        tagLabel.text = text
        self.isSelected = isSelected
        self.layer.cornerRadius = 7
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        backgroundColor = isSelected ? .systemBlue : .systemGray5
        tagLabel.textColor = isSelected ? .white : .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

