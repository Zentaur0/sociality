//
//  NewsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

struct ProfileModel {
    let id: Int
    let firstName: String
    let lastName: String
    let photo: String
}

struct GroupModel {
    let id: Int
    let name: String
    let photo: String
}

struct ItemsModel {
    let id: Int
    let text: String?
    let photoURL: String?
    let photoWidth: Int?
    let photoHeight: Int?
}

// MARK: - NewsVC

final class NewsVC: UIViewController {
    
    // MARK: - Properties
    
    weak var network: NewsFeedProtocol?
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var groups: [GroupModel] = []
    private var items: [ItemsModel] = []
    private var profiles: [ProfileModel] = []
    private var news: [NewsDataSource] = []
    
    // MARK: - Init
    
    init(network: NewsFeedProtocol) {
        self.network = network
        super.init(nibName: nil, bundle: nil)
        loadNewsPosts()
        loadNewsPhotos()
    }
    
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
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.reuseID)
        tableView.register(NewsHeaderCell.self, forCellReuseIdentifier: NewsHeaderCell.reuseID)
        tableView.register(NewsFooterCell.self, forCellReuseIdentifier: NewsFooterCell.reuseID)
        
        view.addSubview(tableView)
        view.backgroundColor = .lightGray
        
        title = "News"
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
                let response = success.response
                let dispatchGroup = DispatchGroup()
                
                var profiles = [ProfileModel]()
                var groups = [GroupModel]()
                var items = [ItemsModel]()
                
                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    for group in response.groups {
                        let model = GroupModel(id: group.id, name: group.name, photo: group.photo)
                        groups.append(model)
                    }
                }
                
                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    for item in response.items {
                        let model = ItemsModel(
                            id: item.id,
                            text: item.text,
                            photoURL: item.attachments?.last?.photo?.sizes.last?.url ?? "",
                            photoWidth: item.attachments?.last?.photo?.sizes.last?.width ?? 0,
                            photoHeight: item.attachments?.last?.photo?.sizes.last?.height ?? 0
                        )
                        items.append(model)
                    }
                }
                
                DispatchQueue.global(qos: .userInteractive).async(group: dispatchGroup) {
                    for profile in response.profiles {
                        let model = ProfileModel(id: profile.id,
                                                 firstName: profile.firstName,
                                                 lastName: profile.lastName,
                                                 photo: profile.photo
                        )
                        profiles.append(model)
                    }
                }
                
                dispatchGroup.notify(queue: .main) {
                    self.groups = groups
                    self.items = items
                    self.profiles = profiles
                    
                    print(self.groups)
                    print(self.items)
                    print(self.profiles)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    private func loadNewsPhotos() {
        network?.getNewsPhotos(httpMethod: .GET, completion: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let success):
                print(success)
            }
        })
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
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsHeaderCell.reuseID,
                                                           for: indexPath) as? NewsHeaderCell else {
                return UITableViewCell()
            }
            
            cell.configure()
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,
                                                           for: indexPath) as? NewsCell else {
                return UITableViewCell()
            }
            
            cell.configure(news: items[indexPath.section])
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterCell.reuseID,
                                                           for: indexPath) as? NewsFooterCell else {
                return UITableViewCell()
            }
            
            cell.onLike = { [weak self] in
                // MARK: TODO: reuse of button and count of likes
//                self?.news[indexPath.section].likeOrDislike()
            }
            
            cell.configure()
            
            return cell
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
