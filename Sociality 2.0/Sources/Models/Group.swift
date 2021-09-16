//
//  Group.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

// MARK: - Group

class Group: Object, Decodable {
    
    // MARK: - Info
    
    /// group name
    @objc dynamic var nickname: String = ""
    /// group avatar
    @objc dynamic var avatar: String = ""
    
    // MARK: - Identifiers
    
    /// group id
    @objc dynamic var id: Int = 0

    // MARK: - Init
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.nickname = json["name"].stringValue
        self.id = json["id"].intValue
        self.avatar = json["photo_100"].stringValue
    }
    
}

// MARK: - Realm

extension Group {
    
    override class func primaryKey() -> String? {
        "id"
    }
    
}
