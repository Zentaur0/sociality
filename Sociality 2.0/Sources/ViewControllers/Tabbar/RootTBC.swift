//
//  RootTBC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

final class RootTBC: UITabBarController {
    
    // MARK: - Properties
    private var friendsVC: UINavigationController?
    private var groupsVC: UINavigationController?
    private var newsVC: UINavigationController?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
    }
}

// MARK: - Methods
extension RootTBC {
    private func setupVC() {
        friendsVC = UINavigationController(rootViewController: FriendsVC())
        groupsVC = UINavigationController(rootViewController: GroupsVC())
        newsVC = UINavigationController(rootViewController: NewsVC())
        
        guard let friendsVC = friendsVC,
              let groupsVC = groupsVC,
              let newsVC = newsVC else { return }
        
//
//        friendsVC.tabBarItem.image = R.image.contacts_icon()
//        groupsVC.tabBarItem.image = R.image.eye_bubble()
//        newsVC.tabBarItem.image = R.image.settings_icon()
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = R.color.whiteBlack()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = R.color.whiteBlack()
        
        setViewControllers([friendsVC, groupsVC, newsVC], animated: true)
    }
}

// MARK: - Constants
extension RootTBC {
    static let friendsTitle = loc.friends_title()
}
