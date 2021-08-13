//
//  AllGroupsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit

final class AllGroupsVC: UIViewController, NavigationControllerSearchDelegate {
    
    // MARK: - Properties
    // Private Properties
    private var tableView: UITableView?
    private var filteredGroups: [Group] = DataProvider.shared.allGroups
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupConstraints()
    }
}

// MARK: - ViewControllerSetupDelegate
extension AllGroupsVC: ViewControllerSetupDelegate {
    func setupVC() {
        tableView = UITableView()
        
        guard let tableView = tableView else { return }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.reuseID)
        
        addSearchController(self.navigationController ?? UINavigationController(),
                            self.navigationItem)
        
        title = AppContainer.shared.groupsTitle
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        guard let tableView = tableView else { return }
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - Methods
extension AllGroupsVC {
    private func showAlert() {
        let alert = UIAlertController(title: "Ups", message: "Group is already added", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Actions
extension AllGroupsVC {
    @objc func addGroupAction() {
        let vc = AppContainer.makeAllGroupsVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension AllGroupsVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filteredGroups = []

        if text.isEmpty {
            filteredGroups = DataProvider.shared.allGroups
        } else {
            for group in DataProvider.shared.allGroups {

                if group.nickname.lowercased().contains(text.lowercased()) {
                    NetworkManager.shared.loadGlobalGroups(token: Session.shared.token,
                                                           userID: String(Session.shared.userId),
                                                           text: text)
                    filteredGroups.append(group)
                }
            }
        }
        
        tableView?.reloadData()
    }
}

// MARK: UITableViewDataSource
extension AllGroupsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupCell.reuseID, for: indexPath) as! GroupCell
        
        let group = filteredGroups[indexPath.row]
        
        cell.name?.text = group.nickname
        cell.avatar?.image = UIImage(named: group.avatar)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension AllGroupsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let group = filteredGroups[indexPath.row]
        
        guard !DataProvider.shared.myGroups.contains(where: { $0.nickname == group.nickname }) else {
            showAlert()
            return
        }
        
        DataProvider.shared.myGroups.append(group)
        navigationController?.popViewController(animated: true)
    }
}
