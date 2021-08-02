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
protocol CellSetupDelegate {
    func setupCell()
    func setupConstraints()
}

// MARK: - NavigationControllerSearchDelegate
protocol NavigationControllerSearchDelegate: UISearchResultsUpdating {
    func addSearchController(_ navigationController: UINavigationController)
}

extension NavigationControllerSearchDelegate {
    func addSearchController(_ navigationController: UINavigationController) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        navigationController.navigationItem.searchController = searchController
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationItem.hidesSearchBarWhenScrolling = true
        navigationController.navigationItem.rightBarButtonItem?.isEnabled = true
//        navigationController.view.backgroundColor = R.color.nvcTint()
//        navigationController.navigationBar.barTintColor = R.color.nvcTint()
    }
}
