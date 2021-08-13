//
//  Session.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import Foundation

final class Session {
    
    // MARK: - Static
    static let shared = Session()
    
    // MARK: - Properties
    var token: String {
        return UserDefaults.standard.string(forKey: "token") ?? ""
    }
    var userId: Int {
        return UserDefaults.standard.integer(forKey: "userID")
    }

    var ownerID: String?
    
    // MARK: - Init
    private init() {}
}
