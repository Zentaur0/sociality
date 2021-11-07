//
//  FriendsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit
import SnapKit
import RealmSwift
import PromiseKit

// MARK: - FriendsVC

final class FriendsVC: UIViewController, NavigationControllerSearchDelegate {
    
    // MARK: - Properties
    // Private Properties
    
    private var tableView: UITableView?
    private var filteredFriends: [RLMFriend] = []
    private var sortedFirstLetters = [String]()
    private var sections = [[RLMFriend]]()
    private var notificationToken: NotificationToken?
    private let refreshControll = UIRefreshControl()
    private let realmCheck: [RLMFriend] = RealmManager.shared.readFromRealm()
    
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

// MARK: - Methods

extension FriendsVC {
    
    private func setupVC() {
        tableView = UITableView()

        guard let tableView = tableView else { return }

        refreshControll.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControll
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

    private func setupConstraints() {
        guard let tableView = tableView else { return }

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

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
        if realmCheck.isEmpty {
            setupBindings()
        } else {
            filteredFriends = realmCheck
            setupsForSectionsAndHeaders()
        }
        tableView?.reloadData()
    }
    
    private func notificate() {
        do {
            let realm = try Realm()
            let realmObject = realm.objects(RLMFriend.self)
            notificationToken = realmObject.observe { (change: RealmCollectionChange) in
                switch change {
                case .error(let error):
                    print(error)
                case .initial(_):
                    self.tableView?.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    self.tableView?.beginUpdates()
                    self.tableView?.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self.tableView?.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self.tableView?.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self.tableView?.endUpdates()
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    private func setupBindings() {
        firstly {
            FriendsNetworkManager.shared.loadFriendsWithPromise(url: URLs.getFriendsURL())
        }.get { friends in
            RealmManager.shared.saveToRealm(object: friends)
        }.map { [weak self] friends in
            self?.filteredFriends = friends
        }.done { [weak self] in
            self?.setupsForSectionsAndHeaders()
            self?.tableView?.reloadData()
        }.catch(policy: .allErrors) { error in
            print(error.localizedDescription)
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
    
    @objc func refresh() {
        setupBindings()
        notificate()
        refreshControll.endRefreshing()
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
            filteredFriends = realmCheck
            setupsForSectionsAndHeaders()
        } else {
            for friend in realmCheck {
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
