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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = R.color.whiteBlack()
        tableView.register(FriendsCell.self, forCellReuseIdentifier: FriendsCell.reuseID)
        
        view.addSubview(tableView)
        
        title = FriendsVC.friendsTitle
        
        addSearchController(self.navigationController ?? UINavigationController(), navigationItem: self.navigationItem)
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
        guard let text = searchController.searchBar.text else { return }
        filteredFriends = []

        if text.isEmpty {
            filteredFriends = DataProvider.shared.allFriends
        } else {
            for friend in DataProvider.shared.allFriends {
                if friend.givenName.lowercased().contains(text.lowercased()) || friend.familyName.lowercased().contains(text.lowercased()) {
                    filteredFriends.append(friend)
                }
            }
        }
        
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
        cell.avatar?.image = UIImage(named: friend.avatar)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FriendsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Constants
extension FriendsVC {
    static let friendsTitle = loc.friends_title()
}
