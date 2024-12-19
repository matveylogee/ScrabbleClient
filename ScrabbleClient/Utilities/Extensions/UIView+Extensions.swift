//
//  UIView+Extensions.swift
//  ScrabbleClient
//
//  Created by Матвей on 17.12.2024.
//

import UIKit

// MARK: - UIView + Extensions
extension UIView {
    func addShadow(color: UIColor = .black, opacity: Float = 0.2, offset: CGSize = CGSize(width: 0, height: 2), radius: CGFloat = 4.0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.masksToBounds = false
    }
    
    func addCornerRadius(_ radius: CGFloat = Constants.UI.cornerRadius) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    /// Закрепляет дочерний UIView к его родительскому UIView с использованием Auto Layout
    func pinToSuperviewEdges(padding: CGFloat = 0) {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding)
        ])
    }
}
