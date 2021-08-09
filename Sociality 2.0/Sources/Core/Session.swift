//
//  Session.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

final class Session {
    
    // MARK: - Static
    static let shared = Session()
    
    // MARK: - Properties
    var token: String = String()
    var userId: Int = Int()
    
    // MARK: - Init
    private init() {}
}
