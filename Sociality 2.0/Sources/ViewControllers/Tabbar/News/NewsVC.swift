//
//  NewsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

private enum NewsCellType: Int {
    case header
    case post
    case footer
}

// MARK: - NewsVC

final class NewsVC: UIViewController {
    
    // MARK: - Properties
    
    weak var network: NewsFeedProtocol?
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var groups: [GroupModel] = []
    private var items: [ItemsModel] = []
    private var profiles: [ProfileModel] = []
    
    // MARK: - Init
    
    init(network: NewsFeedProtocol) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
        loadNewsPosts()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupConstraints()
    }
    
}

// MARK: - Methods

extension NewsVC {
    
    private func setupVC() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = .zero
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
        tableView.register(NewsHeaderCell.self, forCellReuseIdentifier: NewsHeaderCell.reuseID)
        tableView.register(NewsFooterCell.self, forCellReuseIdentifier: NewsFooterCell.reuseID)
        
        view.addSubview(tableView)
        view.backgroundColor = AppContainer.shared.navigationControllerColor
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = AppContainer.shared.newsTitle
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints() {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadNewsPosts() {
        network?.getNewsPosts(httpMethod: .GET) { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                self.groups = success.groups
                self.items = success.items
                self.profiles = success.profiles
                self.tableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension NewsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = NewsCellType(rawValue: indexPath.row)
        let item = self.items[indexPath.section]
        
        switch cellType {
        case .header:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderCell.reuseID,
                                                           for: indexPath) as? NewsHeaderCell else {
                return UITableViewCell()
            }
            
            for group in groups {
                if "-\(group.id)" == String(item.sourceID) {
                    let groupModel = GroupModel(id: group.id,
                                                name: group.name,
                                                photo: group.photo,
                                                date: item.date
                    )
                    cell.configure(model: groupModel)
                }
            }
            
            for profile in profiles {
                if profile.id == item.sourceID {
                    let profileModel = GroupModel(id: profile.id,
                                                  name: profile.firstName + " " + profile.lastName,
                                                  photo: profile.photo,
                                                  date: item.date
                    )
                    cell.configure(model: profileModel)
                }
            }
            
            return cell
        case .post:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,
                                                           for: indexPath) as? NewsCell else {
                return UITableViewCell()
            }
            
            cell.configure(news: item)
            
            return cell
        case .footer:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterCell.reuseID,
                                                           for: indexPath) as? NewsFooterCell else {
                return UITableViewCell()
            }
            
            cell.onLike = { [weak self] in
                DispatchQueue.main.async() {
                    var likedItem = self?.items[indexPath.section]
                    likedItem?.likeOrDislike()
                    self?.items.remove(at: indexPath.section)
                    guard let likedItem = likedItem else { return }
                    self?.items.insert(likedItem, at: indexPath.section)
                }
            }
            
            cell.configure(model: item)
            
            return cell
        case .none:
            return UITableViewCell()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension NewsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 60
        case 1:
            // MARK: TODO - height of the cell must be equal to imageHeight + textHeight
            if let photoURL = items[indexPath.section].photoURL, !photoURL.isEmpty {
                let oldWidth = CGFloat(items[indexPath.section].photoWidth ?? 0)
                let oldHeight = CGFloat(items[indexPath.section].photoHeight ?? 0)
                let scaleFactor = view.frame.width / oldWidth
                let newHeight = CGFloat(oldHeight) * scaleFactor
                return newHeight
            } else {
                return UITableView.automaticDimension
            }
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        0
    }
    
}
