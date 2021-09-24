//
//  Photo.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 14.08.2021.
//

import UIKit
import SwiftyJSON
import RealmSwift

// MARK: Photo

final class Photo: Object {
    /// Photo id
    @objc dynamic var ownerID: Int = 0
    /// Photo url
    @objc dynamic var imageURL: String = ""
    /// Count of likes
    @objc dynamic var likes: Int = 0
    /// photo width
    @objc dynamic var width: Int = 0
    /// photo height
    @objc dynamic var height: Int = 0
    /// photo id
    @objc dynamic var photoID: Int = 0
    
    /// photo owner
    let friend = LinkingObjects(fromType: Friend.self, property: "images")

    // MARK: - Init
    convenience init(json: SwiftyJSON.JSON) {
        self.init()
        self.ownerID = json["owner_id"].intValue
        self.photoID = json["id"].intValue
        let size = json["sizes"].arrayValue.last
        self.imageURL = size?["url"].stringValue ?? ""
        self.width = size?["width"].intValue ?? 0
        self.height = size?["height"].intValue ?? 0
        self.likes = json["likes"]["count"].intValue
    }
    
}

// MARK: - PrimaryKey

extension Photo {
    
    override class func primaryKey() -> String? {
        "photoID"
    }
    
}

extension Photo: Decodable {
    
    /// for conforming to decodable, not using them
    private enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case photoID = "id"
        case imageURL
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
        self.imageURL = pic
        self.likes = likes
        self.width = width
        self.height = height
        self.photoID = photoID
    }
    
}
