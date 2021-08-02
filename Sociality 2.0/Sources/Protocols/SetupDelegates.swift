//
//  SetupDelegates.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

// MARK: - ViewSetupDelegate
protocol ViewSetupDelegate {
    func setupView()
    func setupConstraints()
}

// MARK: - ViewControllerSetupDelegate
protocol ViewControllerSetupDelegate {
    func setupVC()
    func setupConstraints()
}

// MARK: - CellSetupDelegate
protocol CellSetupDelegate {
    func setupCell()
    func setupConstraints()
}
