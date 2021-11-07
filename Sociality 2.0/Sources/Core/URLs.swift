//
//  URLs.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 20.09.2021.
//

import Foundation

// MARK: - URLMethods

private enum URLMethods: String {
    case friends = "friends.get"
    case groups = "groups.get"
    case groupSearch = "groups.search"
    case news = "newsfeed.get"
}

// MARK: - URLs

final class URLs {
    
    // MARK: - Properties
    
    private static let token = Session.shared.token
    private static let userID = String(Session.shared.userId)
    private static let scheme = "https"
    private static let host = "api.vk.com"
    private static let path = "/method/"
    private static let v = "5.131"
    
    // MARK: - Init
    
    private init() {}

    // MARK: - Methods
    
    static func getFriendsURL() -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path + URLMethods.friends.rawValue
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userID),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "fields", value: "photo_100,%20city"),
            URLQueryItem(name: "v", value: v)
        ]
        
        guard let url = urlComponents.url else { return URL(fileURLWithPath: "") }
        
        return url
    }
    
    static func getGroupsURL() -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path + URLMethods.groups.rawValue
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: v)
        ]
        
        guard let url = urlComponents.url else { return URL(fileURLWithPath: "") }
        
        return url
    }
    
    static func getSearchGroupsURL(q: String) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path + URLMethods.groupSearch.rawValue
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "user_id", value: userID),
            URLQueryItem(name: "q", value: q),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "v", value: v)
        ]
        
        guard let url = urlComponents.url else { return URL(fileURLWithPath: "") }
        
        return url
    }
    
    static func getNewsPostURL(startTime: String? = nil, startFrom: String? = "") -> URL {
        print(startFrom)
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path + URLMethods.news.rawValue
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "15"),
            URLQueryItem(name: "v", value: v),
            URLQueryItem(name: "start_from", value: startFrom)
        ]
        
        if startTime != nil {
            urlComponents.queryItems?.append(URLQueryItem(name: "start_time", value: startTime))
        }
        
        guard let url = urlComponents.url else { return URL(fileURLWithPath: "") }
        
        return url
    }
    
}
