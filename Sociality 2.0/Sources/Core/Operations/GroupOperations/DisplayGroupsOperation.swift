//
//  DisplayGroupsOperation.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 24.09.2021.
//

import Foundation

// MARK: - DisplayGroupsOperation

class DisplayGroupsOperation: Operation {
    
    // MARK: - Properties
    
    var groupsVC: GroupsVC
    
    // MARK: - Init
    
    init(groupsVC: GroupsVC) {
        self.groupsVC = groupsVC
    }
    
    // MARK: - Main
    
    override func main() {
        setupOperation()
    }
    
}

// MARK: - Methods

extension DisplayGroupsOperation {
    
    private func setupOperation() {
        guard let groupsLoadedList = dependencies.first as? GroupsLoadAsyncOperation,
              let groups = groupsLoadedList.groups else { return }
        
        groupsVC.filteredGroups = groups
        groupsVC.tableView.reloadData()
    }
    
}
