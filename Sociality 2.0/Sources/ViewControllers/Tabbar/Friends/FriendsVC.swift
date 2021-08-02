//
//  FriendsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

final class FriendsVC: UIViewController {
    
    // MARK: - Properties
    private var tableView: UITableView?
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupConstraints()
    }
}

// MARK: - ViewControllerSetupDelegate
extension FriendsVC: ViewControllerSetupDelegate {
    func setupVC() {
        
    }
    
    func setupConstraints() {
        
    }
}
