//
//  Session.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

final class Session {
    
    // MARK: - Static
    static let shared = Session()
    
    // MARK: - Properties
    var token: String = ""
    var id: Int = Int()
    
    // MARK: - Init
    private init() {}
}
