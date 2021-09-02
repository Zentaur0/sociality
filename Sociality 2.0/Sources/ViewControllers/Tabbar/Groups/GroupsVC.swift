//
//  GroupsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit
import RealmSwift

final class GroupsVC: UIViewController, NavigationControllerSearchDelegate {
    
    // MARK: - Properties
    weak var network: NetworkManagerProtocol?
    
    private let tableView = UITableView()
    private var notificationToken: NotificationToken?
    private var filteredGroups: [Group] = []
    private let refreshControll = UIRefreshControl()
    
    // MARK: - Init
    init(network: NetworkManagerProtocol? = nil) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        provideGroups()
        setupVC()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        provideGroups()
        tableView.reloadData()
    }
}

// MARK: - Methods
extension GroupsVC {
    private func setupVC() {
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.reuseID)
        tableView.refreshControl = refreshControll
        
        refreshControll.addTarget(self, action: #selector(refresh), for: .valueChanged)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addGroupAction))

        addSearchController(self.navigationController ?? UINavigationController(),
                            self.navigationItem)

        title = AppContainer.shared.groupsTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupBindings() {
        network?.loadGroups(url: URLs.getGroups) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let groups):
                self?.filteredGroups = groups
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }

    private func provideGroups() {
        let realmCheck: [Group] = NetworkManager.shared.readFromRealm()
        if realmCheck.isEmpty {
            setupBindings()
        } else {
            filteredGroups = realmCheck
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private func notificate() {
        do {
            let realm = try Realm()
            let realmObject = realm.objects(Group.self)
            notificationToken = realmObject.observe { (change: RealmCollectionChange) in
                switch change {
                case .error(let error):
                    print(error)
                case .initial(_):
                    self.tableView.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    self.tableView.beginUpdates()
                    self.tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self.tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self.tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}),
                                         with: .automatic)
                    self.tableView.endUpdates()
                }
            }
        } catch {
            print(error)
        }
        
    }
    
    @objc func refresh() {
        
        let network = NetworkManager()
        network.loadGroups(url: URLs.getGroups) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let groups):
                self.filteredGroups = groups
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
        
        notificate()
        
        refreshControll.endRefreshing()
    }
    
}

// MARK: - Actions
extension GroupsVC {
    @objc func addGroupAction() {
        let vc = AppContainer.makeAllGroupsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension GroupsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredGroups = []

        if text.isEmpty {
            filteredGroups = DataProvider.shared.myGroups
        } else {
            for group in DataProvider.shared.myGroups {
                if group.nickname.lowercased().contains(text.lowercased()) {
                    filteredGroups.append(group)
                }
            }
        }
        
        tableView.reloadData()
    }
}

// MARK: UITableViewDataSource
extension GroupsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseID,
                                                       for: indexPath) as? GroupCell else {
            return UITableViewCell()
        }
        
        let group = filteredGroups[indexPath.row]

        cell.configure(group: group)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension GroupsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    // MARK: - Navigation
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            DataProvider.shared.myGroups.remove(at: indexPath.row)
            filteredGroups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
            tableView.reloadData()
        }
    }
}
