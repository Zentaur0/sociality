//
//  NewsDataSource.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 17.09.2021.
//

import UIKit

// MARK: - NewsFeedModel

struct NewsFeedItems {
    let groups: [GroupModel]
    let items: [ItemsModel]
    let profiles: [ProfileModel]
    let nextFrom: String
}

// MARK: - ProfileModel

struct ProfileModel {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: String
}

// MARK: - GroupModel

struct GroupModel {
    let id: Int
    let name: String
    let photo: String
    let date: Double
}

// MARK: - ItemsModel

struct ItemsModel {
    let id: Int
    let date: Double
    let sourceID: Int
    let comments: Int?
    var likes: Int
    let text: String?
    let photoURL: String?
    let photoWidth: Int
    let photoHeight: Int
    var isLiked: Bool
    
    mutating func likeOrDislike() {
        isLiked = !isLiked
        likes = isLiked ? likes + 1 : likes - 1
    }
    
    var aspectRatio: CGFloat {
        CGFloat(photoWidth) / CGFloat(photoHeight)
    }
}
