//
//  AppContainer.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

// MARK: - AppContainer

final class AppContainer {

    // MARK: - Static
    
    static let shared = AppContainer()
    
    // MARK: - Properties

    private static let network = NetworkManager()
    private static let newsNetwork = NewsFeedNetworkManager()

    // MARK: - Init
    
    private init() {}
    
    // MARK: - App Constants
    
    let friendsTitle = loc.friends_title()
    let groupsTitle = loc.groups_title()
    let allGroupsTitle = loc.all_groups_title()
    let newsTitle = loc.news_title()
    let navigationControllerColor = R.color.whiteBlack()
    let textColor = R.color.blackWhite()
    
    // MARK: - Methods
    
    static func makeRootController() -> UIViewController {
        let isAuthorized = UserDefaults.standard.bool(forKey: "isAuthorized")
        return isAuthorized ? RootTBC() : LoginVC()
    }
    
    static func makeRootTBC() -> RootTBC {
        return RootTBC()
    }
    
    static func makeFriendsVC() -> FriendsVC {
        return FriendsVC(network: network)
    }
    
    static func makeGroupsVC() -> GroupsVC {
        return GroupsVC()
    }
    
    static func makeAllGroupsVC() -> AllGroupsVC {
        return AllGroupsVC(network: network)
    }
    
    static func makeFriendInfoVC(friend: Friend) -> FriendInformationVC {
        return FriendInformationVC(friend: friend)
    }
    
    static func makeNewsVC() -> NewsVC {
        return NewsVC(network: newsNetwork)
    }
    
    // MARK: Spinner
    
    static func createSpinnerView(_ onViewController: UIViewController,
                                  _ showViewController: UIViewController) {
        let child = Spinner()
        
        // add the spinner view controller
        onViewController.addChild(child)
        child.view.frame = onViewController.view.bounds
        onViewController.view.addSubview(child.view)
        child.didMove(toParent: onViewController.self)
        
        // whait 1.5 seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
            AppDelegate.shared.window?.rootViewController = showViewController
        }
    }
    
}
