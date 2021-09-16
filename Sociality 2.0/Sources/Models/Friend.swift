//
//  Friend.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 03.08.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

// MARK: - Friend

final class Friend: Object, Decodable {
    
    // MARK: - Info
    
    /// Friend given name
    @objc dynamic var givenName: String = ""
    /// Friend famaly name
    @objc dynamic var familyName: String = ""
    /// Friend avatar
    @objc dynamic var avatar: String = ""
    /// Friend city
    @objc dynamic var city: String = ""
    
    // MARK: - Identifiers
    
    /// Friend ID
    @objc dynamic var id: Int = 0
    
    // MARK: - Content
    
    /// Friend's images
    var images = List<Photo>()

    // MARK: - Init
    
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.id = json["id"].intValue
        self.givenName = json["first_name"].stringValue
        self.familyName = json["last_name"].stringValue
        self.city = json["city"]["title"].stringValue
        self.avatar = json["photo_100"].stringValue
    }
    
    convenience init(givenName: String,
                     familyName: String,
                     avatar: String,
                     city: String,
                     id: Int,
                     images: [Photo] = []) {
        
        self.init()
        self.givenName = givenName
        self.familyName = familyName
        self.avatar = avatar
        self.city = city
        self.id = id
        
        self.images.append(objectsIn: images)
    }
    
}

// MARK: - PrimaryKey

extension Friend {
    
    override class func primaryKey() -> String? {
        "id"
    }
    
}
