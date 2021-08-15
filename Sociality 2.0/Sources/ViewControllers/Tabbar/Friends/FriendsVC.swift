//
//  FriendsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit
import SnapKit
import RealmSwift

final class FriendsVC: UIViewController, NavigationControllerSearchDelegate {
    
    // MARK: - Properties
    // Private Properties
    private var tableView: UITableView?
    private var filteredFriends: [Friend] = DataProvider.shared.allFriends
    private var sortedFirstLetters = [String]()
    private var sections = [[Friend]]()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        provideFriends()
        setupVC()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
    }
}

// MARK: - ViewControllerSetupDelegate
extension FriendsVC: ViewControllerSetupDelegate {
    func setupVC() {
        tableView = UITableView()
        
        guard let tableView = tableView else { return }
        
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = R.color.whiteBlack()
        tableView.register(FriendTableCell.self, forCellReuseIdentifier: FriendTableCell.reuseID)
        
        view.addSubview(tableView)
        
        addSearchController(self.navigationController ?? UINavigationController(),
                            self.navigationItem)
        
        title = AppContainer.shared.friendsTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: loc.friends_logout(),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(logoutAction))
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupConstraints() {
        guard let tableView = tableView else { return }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - Methods
extension FriendsVC {
    private func setupsForSectionsAndHeaders() {
        var firstLetters: [String] = []
        for i in filteredFriends {
            if let firstLetter = i.givenName.first {
                firstLetters.append(String(firstLetter))
            } else {
                firstLetters.append("#")
            }
        }
        let uniqueFirstLetters = Array(Set(firstLetters))
        sortedFirstLetters = uniqueFirstLetters.sorted()
        
        sections = sortedFirstLetters.map { firstLetter in
            return filteredFriends
                .filter { String($0.givenName.first ?? Character("")) == firstLetter }
                .sorted(by: { $0.givenName < $1.givenName })
        }
    }

    private func provideFriends() {
        let network = NetworkManager()
        network.loadFriends(url: URLs.getFriends) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let data):
                DataProvider.shared.allFriends = data
                self.filteredFriends = data
                self.setupsForSectionsAndHeaders()
                DispatchQueue.main.async { [weak self] in
                    self?.tableView?.reloadData()
                }
            }
        }
    }

}

// MARK: - Actions
extension FriendsVC {
    @objc private func logoutAction() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: {_ in
            UserDefaults.standard.set(false, forKey: "isAuthorized")
            AppContainer.createSpinnerView(self.tabBarController ?? UITabBarController(), AppContainer.makeRootController())
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(yesAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - UISearchResultsUpdating
extension FriendsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredFriends = []
        sections = [[]]
        sortedFirstLetters = []

        if text.isEmpty {
            filteredFriends = DataProvider.shared.allFriends
            setupsForSectionsAndHeaders()
        } else {
            for friend in DataProvider.shared.allFriends {
                if friend.givenName.lowercased().contains(text.lowercased()) || friend.familyName.lowercased().contains(text.lowercased()) {
                    filteredFriends.append(friend)
                    setupsForSectionsAndHeaders()
                }
            }
        }
        
        tableView?.reloadData()
    }

}

// MARK: - UITableViewDataSource
extension FriendsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sortedFirstLetters[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sortedFirstLetters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendTableCell.reuseID,
                                                       for: indexPath) as? FriendTableCell else {
            return UITableViewCell()
        }
        
        let friend = sections[indexPath.section][indexPath.row]
        
        cell.configure(friend: friend)
        
        return cell
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sortedFirstLetters
    }

}

// MARK: - UITableViewDelegate
extension FriendsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let friend = sections[indexPath.section][indexPath.row]
        let vc = AppContainer.makeFriendInfoVC(friend: friend)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
