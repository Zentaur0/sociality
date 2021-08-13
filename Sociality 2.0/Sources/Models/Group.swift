//
//  Group.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

struct Group: Decodable {
    // MARK: - Info
    /// group name
    var nickname: String
    /// group bio
    var bio: String
    /// group hashtags
    var areaOfInterests: String
    /// group avatar
    var avatar: String
    
    // MARK: - Identifiers
    /// group id
    let id: String
}
