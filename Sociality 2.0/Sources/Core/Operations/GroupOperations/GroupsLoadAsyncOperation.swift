//
//  GroupsLoadAsyncOperation.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 24.09.2021.
//

import Foundation
import SwiftyJSON

// MARK: - GroupsLoadAsyncOperation

class GroupsLoadAsyncOperation: Operation {
    
    // MARK: - Properties
    
    var groups: [Group]?
    
    // MARK: - Main
    
    override func main() {
        setupOperation()
    }
    
}

// MARK: - Methods

extension GroupsLoadAsyncOperation {
    
    private func setupOperation() {
        guard let groupsListData = dependencies.first as? GroupsRequestOperation,
              let data = groupsListData.data else { return }
        
        do {
            let json = try JSON(data: data)
            let groupJSON = json["response"]["items"].arrayValue
            let groups = groupJSON.map { Group(json: $0)}
            self.groups = groups
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
