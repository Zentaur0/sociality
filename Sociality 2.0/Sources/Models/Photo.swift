//
//  Photo.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 14.08.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

final class Photo: Object, Decodable {
    /// Photo id
    @objc dynamic var ownerID: Int = 0
    /// Photo self
    @objc dynamic var pic: String = ""
    /// Count of likes
    @objc dynamic var likes: Int = 0
    /// photo width
    @objc dynamic var width: Int = 0
    /// photo height
    @objc dynamic var height: Int = 0
    /// photo id
    @objc dynamic var photoID: Int = 0
    
    let friend = LinkingObjects(fromType: Friend.self, property: "images")

    // MARK: - Init
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.ownerID = json["owner_id"].intValue
        self.photoID = json["id"].intValue
        let size = json["sizes"].arrayValue.last
        self.pic = size?["url"].stringValue ?? ""
        self.width = size?["width"].intValue ?? 0
        self.height = size?["height"].intValue ?? 0
        self.likes = json["likes"]["count"].intValue
    }
    
    /// for conforming to decodable, not using them
    private enum CodingKeys: String, CodingKey {
        case ownerID
        case photoID
        case pic
        case width
        case height
        case likes
    }
    
    convenience init(ownerID: Int,
                     pic: String,
                     likes: Int,
                     width: Int,
                     height: Int,
                     photoID: Int) {

        self.init()
        self.ownerID = ownerID
        self.pic = pic
        self.likes = likes
        self.width = width
        self.height = height
        self.photoID = photoID
    }
    
}

// MARK: - PrimaryKey

extension Photo {
    
    override class func primaryKey() -> String? {
        "photoID"
    }
    
}
