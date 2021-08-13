//
//  Group.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit
import SwiftyJSON

struct Group: Decodable {
    // MARK: - Info
    /// group name
    var nickname: String
    /// group bio
//    var bio: String
    /// group hashtags
//    var areaOfInterests: String
    /// group avatar
    var avatar: String
    
    // MARK: - Identifiers
    /// group id
    let id: Int

    init(json: SwiftyJSON.JSON) {
        self.nickname = json["name"].stringValue
        self.id = json["id"].intValue
        self.avatar = json["photo_100"].stringValue
    }

    enum CodingKeys: String, CodingKey {
        case nickname = "name"
        case id = "id"
        case avatar = "photo_100"
    }
}
