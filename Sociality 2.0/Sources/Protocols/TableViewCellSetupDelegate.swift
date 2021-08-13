//
//  TableViewCellSetupDelegate.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit

// MARK: - CellSetupDelegate
protocol TableViewCellSetupDelegate {
    func setupCell()
    func setupConstraints()
    func setupShadow(_ avatar: UIImageView, _ shadowView: UIView)
}

extension TableViewCellSetupDelegate {
    func setupShadow(_ avatar: UIImageView, _ shadowView: UIView) {
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 25
        
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = UIColor.systemGray5.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: -5, y: -5, width: 60, height: 60),
                                                   cornerRadius: 25).cgPath
    }
}
