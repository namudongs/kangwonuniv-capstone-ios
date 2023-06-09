//
//  CustomButton.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/26.
//

import UIKit

class CustomButton: UIButton {
    
    // MARK: - SystemImage Button
    init(color: UIColor!, systemImage: String) {
        super.init(frame: .zero)
        
        guard let thisImage = UIImage(systemName:systemImage)?.withConfiguration(UIImage.SymbolConfiguration(scale: .small))
        else { return }
        
        self.setImage(thisImage, for: .normal)
        self.tintColor = color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
