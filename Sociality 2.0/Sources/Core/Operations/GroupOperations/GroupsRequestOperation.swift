//
//  GroupsRequestOperation.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 24.09.2021.
//

import Foundation

// MARK: - GroupsRequestOperation

final class GroupsRequestOperation: Operation {
    
    // MARK: - Properties
    
    var data: Data?
    
    // MARK: - Main
    
    override func main() {
        setupOperation()
    }
    
}

// MARK: - Methods

extension GroupsRequestOperation {
    
    private func setupOperation() {
        let url = URLs.getGroupsURL()
        
        guard let data = try? Data(contentsOf: url) else { return }
        
        self.data = data
    }
    
}
