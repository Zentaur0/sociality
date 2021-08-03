//
//  AppContainer.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

let loc = R.string.localizable.self
typealias EmptyClosure = (() -> Void)

final class AppContainer {
    
    static let shared = AppContainer()
    
    // MARK: - App Constants
    let friendsTitle = loc.friends_title()
    let groupsTitle = loc.groups_title()
    let allGroupsTitle = loc.all_groups_title()
    let newsTitle = loc.news_title()
    let navigationControllerColor = R.color.whiteBlack()
    let textColor = R.color.blackWhite()
    
    // MARK: - Methods
    static func makeRootController() -> UINavigationController {
        
        if User.isAuthorized {
            // TODO: add tabbar when user is autorized
            return UINavigationController(rootViewController: RootTBC())
        } else {
            return UINavigationController(rootViewController: LoginVC())
        }
    }
    
    static func makeRootTBC() -> RootTBC {
        return RootTBC()
    }
    
    static func makeFriendsVC() -> FriendsVC {
        return FriendsVC()
    }
    
    static func makeGroupsVC() -> GroupsVC {
        return GroupsVC()
    }
    
    static func makeAllGroupsVC() -> AllGroupsVC {
        return AllGroupsVC()
    }
}
