//
//  RootTBC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

final class RootTBC: UITabBarController {
    
    // MARK: - Properties
    private var friendsVC: FriendsVC?
    private var groupsVC: GroupsVC?
    private var newsVC: NewsVC?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupConstraints()
    }
    
    
}

// MARK: - ViewControllerSetupDelegate
extension RootTBC: ViewControllerSetupDelegate {
    func setupVC() {
        friendsVC = FriendsVC()
        groupsVC = GroupsVC()
        newsVC = NewsVC()
        
        guard let friendsVC = friendsVC,
              let groupsVC = groupsVC,
              let newsVC = newsVC else { return }
        
        
        
        setViewControllers([friendsVC, groupsVC, newsVC], animated: true)
    }
    
    func setupConstraints() {
        guard let friendsVC = friendsVC,
              let groupsVC = groupsVC,
              let newsVC = newsVC else { return }
        
        
    }
}
