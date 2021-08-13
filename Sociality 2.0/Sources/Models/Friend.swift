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
    var images: [Photo] = []
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

struct Photo: Decodable {
    /// Photo id
    let ownerID: Int
    /// Photo self
    let pic: String
    /// Count of likes
    let likes: Int

    let width: Int
    let height: Int

    init(json: SwiftyJSON.JSON) {
        self.ownerID = json["owner_id"].intValue
        let size = json["sizes"].arrayValue.last
        self.pic = size?["url"].stringValue ?? ""
        self.width = size?["width"].intValue ?? 0
        self.height = size?["height"].intValue ?? 0
        self.likes = json["likes"]["count"].intValue
    }
}
//
//{
//    "response": {
//        "count": 136,
//        "items": [
//            {
//                "album_id": -7,
//                "date": 1513976785,
//                "id": 456241346,
//                "owner_id": 59274009,
//                "has_tags": false,
//                "post_id": 9374,
//                "sizes": [
//                    {
//                        "height": 128,
//                        "url": "https://sun9-73.userapi.com/impf/c841338/v841338980/4b205/wCv-wPA5amE.jpg?size=130x128&quality=96&sign=f308fa18ffc6a4ddc926b4fe66021f67&c_uniq_tag=l3E8nWN5NjLHIzUMVqCft9kEEol1JLCfA2IR_rnOkFs&type=album",
//                        "type": "m",
//                        "width": 130
//                    },
//                    {
//                        "height": 128,
//                        "url": "https://sun9-73.userapi.com/impf/c841338/v841338980/4b205/wCv-wPA5amE.jpg?size=130x128&quality=96&sign=f308fa18ffc6a4ddc926b4fe66021f67&c_uniq_tag=l3E8nWN5NjLHIzUMVqCft9kEEol1JLCfA2IR_rnOkFs&type=album",
//                        "type": "o",
//                        "width": 130
//                    },
//                    {
//                        "height": 196,
//                        "url": "https://sun9-73.userapi.com/impf/c841338/v841338980/4b205/wCv-wPA5amE.jpg?size=200x196&quality=96&sign=e010f6fcffa0af9f37e57b3293c33634&c_uniq_tag=dB3Z0_lHsh9zaQsWHorEtRtkTXSRa1fNvvx2k7u6cN4&type=album",
//                        "type": "p",
//                        "width": 200
//                    },
//                    {
//                        "height": 314,
//                        "url": "https://sun9-73.userapi.com/impf/c841338/v841338980/4b205/wCv-wPA5amE.jpg?size=320x314&quality=96&sign=f75a08fb11a53752d8ef6f75b57ca0b8&c_uniq_tag=qjqVviO41yu3dazSBaYNdJwTDGazs_JKlSpHiZoJ6b4&type=album",
//                        "type": "q",
//                        "width": 320
//                    }
//                ],
//                "text": "",
//                "likes": {
//                    "user_likes": 0,
//                    "count": 33
//                },
//                "reposts": {
//                    "count": 0
//                }
//            },
