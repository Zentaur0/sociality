//
//  UIFont + Extensions.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 07.11.2021.
//

import Foundation
import UIKit

// MARK: - Flyweight pattern

extension UIFont {
    static let loginLabelFont = UIFont.systemFont(ofSize: 27, weight: .semibold)
    static let textFieldFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    static let buttonFont = UIFont.systemFont(ofSize: 17, weight: .bold)
    static let friendNameFont = UIFont.systemFont(ofSize: 17, weight: .semibold)
    static let friendAgeFont = UIFont.systemFont(ofSize: 13, weight: .thin)
}
