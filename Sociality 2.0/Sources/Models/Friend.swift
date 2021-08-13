//
//  Friend.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 03.08.2021.
//

import UIKit
import SwiftyJSON

struct Friend: Decodable {
    // MARK: - Info
    /// User given name
    var givenName: String
    /// User famaly name
    var familyName: String
    /// User age
//    var age: Int
    /// User avatar
    var avatar: String

    var city: String
    
    // MARK: - Identifiers
    /// User ID
    let id: Int
    
    // MARK: - Content
//    /// User's images
//    var images: [String] = []
//    /// User's posts
//    var posts: [Post] = []
//    /// User's groups
//    var groups: [Group] = []

    init(json: SwiftyJSON.JSON) {
        self.id = json["id"].intValue
        self.givenName = json["first_name"].stringValue
        self.familyName = json["last_name"].stringValue
        self.city = json["city"]["title"].stringValue
        self.avatar = json["photo_100"].stringValue
    }
}
