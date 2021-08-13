//
//  SetupDelegates.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit
import SnapKit

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
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: -5, y: -5, width: 60, height: 60), cornerRadius: 25).cgPath
    }
}

// MARK: - NavigationControllerSearchDelegate
protocol NavigationControllerSearchDelegate: UISearchResultsUpdating {
    func addSearchController(_ navController: UINavigationController,
                             _ navItem: UINavigationItem)
}

extension NavigationControllerSearchDelegate {
    func addSearchController(_ navController: UINavigationController,
                             _ navItem: UINavigationItem) {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navItem.searchController = searchController
        navController.navigationBar.isTranslucent = false
        navController.navigationItem.hidesSearchBarWhenScrolling = true
        navController.navigationItem.rightBarButtonItem?.isEnabled = true
        navController.view.backgroundColor = AppContainer.shared.navigationControllerColor
        navController.navigationBar.barTintColor = AppContainer.shared.navigationControllerColor
    }
}
