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
    let text: String
    let attachments: [NewsItemAttachment]?
    
    enum CodingKeys: String, CodingKey {
        case id = "post_id"
        case text
        case attachments
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
