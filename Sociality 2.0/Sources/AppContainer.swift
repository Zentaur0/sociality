//
//  AppContainer.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

let loc = R.string.localizable.self

final class AppContainer {
    // Methods
    static func makeRootController() -> UINavigationController {
        
        if User.isAuthorized {
            // TODO: add tabbar when user is autorized
            return UINavigationController(rootViewController: RootTBC())
        } else {
            return UINavigationController(rootViewController: LoginVC())
        }
    }
    
    // MARK: - Global Constants
    static let friendsTitle = loc.friends_title()
    static let navigationControllerColor = R.color.whiteBlack()
    static let textColor = R.color.blackWhite()
}
