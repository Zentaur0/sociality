//
//  GroupsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit
import RealmSwift

// MARK: - GroupsVC

final class GroupsVC: UIViewController, NavigationControllerSearchDelegate {
    
    // MARK: - Properties
    
    var filteredGroups: [Group] = []
    let tableView = UITableView()
    
    private var notificationToken: NotificationToken?
    private let refreshControll = UIRefreshControl()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
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
        let operationQueue = OperationQueue()
        
        let groupRequest = GroupsRequestOperation()
        let loadGroups = GroupsLoadAsyncOperation()
        let displayGroups = DisplayGroupsOperation(groupsVC: self)
        let saveGroupsToRealm = SaveGroupsToRealmOperation()
        
        operationQueue.addOperation(groupRequest)
        loadGroups.addDependency(groupRequest)
        operationQueue.addOperation(loadGroups)
        displayGroups.addDependency(loadGroups)
        saveGroupsToRealm.addDependency(loadGroups)
        
        OperationQueue.main.addOperation(saveGroupsToRealm)
        OperationQueue.main.addOperation(displayGroups)
    }

    private func provideGroups() {
        let realmCheck: [Group] = RealmManager.shared.readFromRealm()
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
    
}

// MARK: - Actions

extension GroupsVC {
    
    @objc func addGroupAction() {
        let vc = AppContainer.makeAllGroupsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func refresh() {
        setupBindings()
        
        notificate()
        
        refreshControll.endRefreshing()
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
