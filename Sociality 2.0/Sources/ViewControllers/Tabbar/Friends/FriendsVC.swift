//
//  FriendsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit
import SnapKit

final class FriendsVC: UIViewController, NavigationControllerSearchDelegate {
    
    // MARK: - Properties
    private var tableView: UITableView?
    private var filteredFriends: [Friend] = DataProvider.shared.allFriends
    
    internal var user: User?
    
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
        tableView = UITableView()
        
        guard let tableView = tableView else { return }
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.reuseID)
        
        addSearchController((navigationController ?? UINavigationController()).self)
    }
    
    func setupConstraints() {
        guard let tableView = tableView else { return }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UISearchResultsUpdating
extension FriendsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//        filteredContacts = []
//
//        if text.isEmpty {
//            filteredContacts = DataProvider.shared.localContacts
//            tableView?.tableHeaderView = headerView
//        } else {
//            tableView?.tableHeaderView = UIView()
//            for contact in DataProvider.shared.localContacts {
//                if contact.givenName.lowercased().contains(text.lowercased()) || contact.familyName.lowercased().contains(text.lowercased()) {
//                    filteredContacts.append(contact)
//                }
//            }
//        }
        
        tableView?.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FriendsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredFriends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FriendsCell.reuseID, for: indexPath) as! FriendsCell
        
        let friend = filteredFriends[indexPath.row]
        
        cell.name?.text = friend.givenName + " " + friend.familyName
        cell.age?.text = friend.age
        cell.avatar?.image = UIImage(systemName: "plus")
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FriendsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
