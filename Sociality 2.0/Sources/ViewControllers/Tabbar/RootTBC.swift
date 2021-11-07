//
//  RootTBC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

// MARK: - RootTBC

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
        friendsVC = UINavigationController(rootViewController: AppContainer.makeFriendsVC())
        groupsVC = UINavigationController(rootViewController: AppContainer.makeGroupsVC())
        newsVC = UINavigationController(rootViewController: AppContainer.makeNewsVC())
        
        guard let friendsVC = friendsVC,
              let groupsVC = groupsVC,
              let newsVC = newsVC else { return }
        
        setupChildVC(on: friendsVC, title: AppContainer.shared.friendsTitle, selectedImg: R.image.person2Fill(), normalImg: R.image.person2())
        setupChildVC(on: groupsVC, title: AppContainer.shared.groupsTitle, selectedImg: R.image.rectanglesGroupFill(), normalImg: R.image.rectanglesGroup())
        setupChildVC(on: newsVC, title: AppContainer.shared.newsTitle, selectedImg: R.image.newspaperFill(), normalImg: R.image.newspaper())
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = R.color.whiteBlack()
        tabBar.tintColor = R.color.blackWhite()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = R.color.whiteBlack()
        
        setViewControllers([friendsVC, groupsVC, newsVC], animated: true)
    }
    
    private func setupChildVC(on viewController: UIViewController,
                         title: String,
                         selectedImg: UIImage?,
                         normalImg: UIImage?) {
        let imageInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        viewController.title = title
        viewController.tabBarItem.image = normalImg
        viewController.tabBarItem.selectedImage = selectedImg
        viewController.tabBarItem.imageInsets = imageInsets
        viewController.tabBarItem.selectedImage?.withTintColor(.black)
        viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
        viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.black], for: .selected)
    }
    
}

