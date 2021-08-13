//
//  Post.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 05.08.2021.
//

import UIKit

struct Post: Decodable {
    var id: String
    let user: Friend
    let time: String
    
    var images: [String] = []
    var info: String
    var likeCount: Int
}
