//
//  UIStackViewExtension.swift
//  myQuestion
//
//  Created by namdghyun on 2023/05/25.
//

import UIKit

extension UIStackView {

    func addArrangedSubviews (_ views: UIView...) {
        views.forEach { [weak self] view in
            view.translatesAutoresizingMaskIntoConstraints = false
            self?.addArrangedSubview(view)
        }
    }

    func setHorizontalStack() {
        axis = .horizontal
        alignment = .center
        distribution = .equalSpacing
    }
    
    func setVerticalStack() {
        axis = .horizontal
        alignment = .center
        distribution = .equalSpacing
    }
}
