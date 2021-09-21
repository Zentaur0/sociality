//
//  User.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

// MARK: User

struct User {
    
    // MARK: - Info
    
    var givenName: String
    var familyName: String
    var age: Int
    var avatar: String
    
    // MARK: - Identifiers
    
    let id: String
    var userName: String
    
    // MARK: - Content
    
    var images: [String] = []
    var groups: [Group] = []
    
}
