//
//  DataProvider.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 03.08.2021.
//

final class DataProvider {
    
    // MARK: - Static
    static let shared = DataProvider()
    
    // MARK: - Init
    private init() {}
    
    // MARK: - Properties
    var allFriends: [Friend] = []
    
    var myGroups: [Group] = []
    
    var allGroups: [Group] = []
    
}
