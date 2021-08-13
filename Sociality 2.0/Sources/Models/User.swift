//
//  User.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

struct User {
    // MARK: - Info
    var givenName: String
    var familyName: String
    var age: Int
    var avatar: String
    
    // MARK: - Identifiers
    var id: String
    var userName: String
    
    // MARK: - Statics
    static var isAuthorized: Bool = false
}
