//
//  NavigationControllerSearchDelegate.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit

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
