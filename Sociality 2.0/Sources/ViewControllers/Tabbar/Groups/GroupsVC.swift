//
//  GroupsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

final class GroupsVC: UIViewController, NavigationControllerSearchDelegate {
    
    // MARK: - Properties
    private let tableView = UITableView()
    
    private var filteredGroups: [Group] = []
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        provideGroups()
        setupVC()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        filteredGroups = DataProvider.shared.myGroups
        tableView.reloadData()
    }
}

// MARK: - ViewControllerSetupDelegate
extension GroupsVC: ViewControllerSetupDelegate {
    func setupVC() {
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.reuseID)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addGroupAction))
        
        addSearchController(self.navigationController ?? UINavigationController(),
                            self.navigationItem)
        
        title = AppContainer.shared.groupsTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
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

// MARK: - Methods
extension GroupsVC {
    private func provideGroups() {
        NetworkManager.shared.loadGroups(url: URLs.getGroups) { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let groups):
                DataProvider.shared.myGroups = groups
                self?.filteredGroups = groups
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
    }
}
