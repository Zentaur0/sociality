//
//  NewsDataSource.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 17.09.2021.
//

import Foundation

// MARK: - NewsDataSourceProtocol

protocol NewsDataSourceProtocol {
    var author: String { get }
    var time: String { get }
    var avatar: String { get }
    var image: String? { get set }
    var text: String? { get set }
    var likes: String { get set }
    var comments: String { get set }
}

// MARK: - NewsDataSource

struct NewsDataSource: NewsDataSourceProtocol {
    let author: String
    let avatar: String
    let time: String
    var likes: String
    var comments: String
    var image: String?
    var text: String?
    var isLiked: Bool = false
    
    mutating func likeOrDislike() {
        isLiked = !isLiked
    }
}
