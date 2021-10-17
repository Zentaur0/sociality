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
    private var nextFrom = ""
    private var isLoading = false
    private var profiles: [ProfileModel] = []
    private let refresh = UIRefreshControl()
    private var textHeight = CGFloat()
    private var imageHeight = CGFloat()
    
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
        tableView.prefetchDataSource = self
        tableView.separatorInset = .zero
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
        tableView.register(NewsHeaderCell.self, forCellReuseIdentifier: NewsHeaderCell.reuseID)
        tableView.register(NewsFooterCell.self, forCellReuseIdentifier: NewsFooterCell.reuseID)
        
        view.addSubview(tableView)
        view.backgroundColor = AppContainer.shared.navigationControllerColor
        navigationController?.navigationBar.prefersLargeTitles = true
        
        title = AppContainer.shared.newsTitle
        setupRefresh()
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints() {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func loadNewsPosts() {
        let url = URLs.getNewsPostURL()
        network?.getNewsPosts(httpMethod: .GET, url: url) { result, _  in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                self.groups = success.groups
                self.items = success.items
                self.profiles = success.profiles
                self.nextFrom = success.nextFrom ?? ""
                self.tableView.reloadData()
            }
        }
    }
    
    private func setupRefresh() {
        refresh.attributedTitle = NSAttributedString(string: "Refreshing")
        refresh.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
        tableView.addSubview(refresh)
    }
    
}

// MARK: - Actions

extension NewsVC {
    
    @objc private func refreshNews() {
        refresh.beginRefreshing()
        let mostFreshNewsDate = items.first?.date ?? Date().timeIntervalSince1970
        let startTime = String(mostFreshNewsDate + 1)
        let url = URLs.getNewsPostURL(startTime: startTime)
        network?.getNewsPosts(httpMethod: .GET, url: url) { [weak self] result, _  in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let news):
                self?.refresh.endRefreshing()
                guard let self = self else { return }
                guard self.items.count > 0 else { return }
                
                let oldItemsCount = self.items.count
                let newItemsCount = news.items.count + self.items.count
                
                self.groups = news.groups + self.groups
                self.profiles = news.profiles + self.profiles
                self.items = news.items + self.items
                
                let indexSet = IndexSet(integersIn: 0..<news.items.count)
                
                if oldItemsCount < newItemsCount {
                    self.tableView.insertSections(indexSet, with: .fade)
                }
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
                    let groupModel = GroupModel(
                        id: group.id,
                        name: group.name,
                        photo: group.photo,
                        date: item.date
                    )
                    cell.configure(model: groupModel)
                }
            }
            
            for profile in profiles {
                if profile.id == item.sourceID {
                    let profileModel = GroupModel(
                        id: profile.id,
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
            cell.onButton = { [weak self] in
                self?.textHeight = cell.textHeight
                self?.imageHeight = cell.imageHeight
            }
            
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
                return newHeight + textHeight
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

// MARK: - UITableViewDataSourcePrefetching

extension NewsVC: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard let maxSection = indexPaths.map({ $0.section }).max() else { return }
        
        if maxSection > items.count - 3, !isLoading {
            isLoading = true
            
            let url = URLs.getNewsPostURL(startFrom: nextFrom)
            network?.getNewsPosts(httpMethod: .GET, url: url) { [weak self] response, nextFrom in
                switch response {
                case .failure(let error):
                    print(error)
                case .success(let news):
                    guard let self = self else { return }
                    let indexSet = IndexSet(integersIn: self.items.count..<self.items.count + news.items.count)
                    self.groups.append(contentsOf: news.groups)
                    self.profiles.append(contentsOf: news.profiles)
                    self.items.append(contentsOf: news.items)
                    self.nextFrom = news.nextFrom
                    self.tableView.insertSections(indexSet, with: .fade)
                    self.isLoading = false
                }
            }
        }
    }
    
}
