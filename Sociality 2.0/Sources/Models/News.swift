//
//  Post.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 05.08.2021.
//

import UIKit

// MARK: - NewsResponse

struct NewsResponse: Decodable {
    let response: NewsResponseItem
}

// MARK: - NewsResponseItem

struct NewsResponseItem: Decodable {
    let groups: [NewsGroup]
    let items: [NewsItem]
    let profiles: [NewsProfile]
    let next_from: String?
}

// MARK: - NewsGroup

struct NewsGroup: Decodable {
    let id: Int
    let photo: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_200"
        case name
    }
}

// MARK: - NewsItem

struct NewsItem: Decodable {
    let id: Int
    let date: Double
    let text: String
    let attachments: [NewsItemAttachment]?
    let sourceID: Int
    let comments: NewsItemComments?
    let likes: NewsItemLikes?
    
    enum CodingKeys: String, CodingKey {
        case id = "post_id"
        case date
        case text
        case attachments
        case sourceID = "source_id"
        case comments
        case likes
    }
}

// MARK: - NewsItemComments

struct NewsItemComments: Decodable {
    let count: Int
}

// MARK: - NewsItemLikes

struct NewsItemLikes: Decodable {
    let count: Int
    let userLikes: Int
    
    enum CodingKeys: String, CodingKey {
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - NewsProfile

struct NewsProfile: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo_100"
    }
}

// MARK: - NewsItemAttachment

struct NewsItemAttachment: Decodable {
    let photo: NewsPhoto?
}

// MARK: - NewsPhoto

struct NewsPhoto: Decodable {
    let id: Int
    let sizes: [NewsPhotoSize]
}

// MARK: - NewsPhotoSize

struct NewsPhotoSize: Decodable {
    let width: Int
    let height: Int
    let url: String
}
