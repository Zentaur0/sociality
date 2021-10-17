//
//  SaveGroupsToRealmOperation.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 24.09.2021.
//

import Foundation

// MARK: - SaveGroupsToRealmOperation

class SaveGroupsToRealmOperation: Operation {
    
    // MARK: - Properties
    
    var groups: [Group]?
    
    // MARK: - Main
    
    override func main() {
        setupOperation()
    }
    
}

// MARK: - Methods

extension SaveGroupsToRealmOperation {
    
    private func setupOperation() {
        guard let objects = dependencies.first as? GroupsLoadAsyncOperation,
              let groups = objects.groups else { return }
        
        self.groups = groups
        RealmManager.shared.saveToRealm(object: groups)
    }
    
}
