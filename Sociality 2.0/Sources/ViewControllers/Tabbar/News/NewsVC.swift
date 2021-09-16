//
//  NewsVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 02.08.2021.
//

import UIKit

// MARK: - NewsVC

final class NewsVC: UIViewController {
    
    // MARK: - Properties
    
    private var tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var news: [NewsDataSource] = [
        NewsDataSource(author: "anton", avatar: "carsAvatar", time: "19:32:22", likes: "71", comments: "9", image: "images", text: "aksjdfxibux buxoivcub iu cxiovb qifiu izuop xicubit w9ij ifjz ;oiub 8vjt49i uscovj8357g izuop xicubit w9ij ifjz ;oiub 8vjt49i uscovj8357g izuop xicubit w9ij ifjz ;oiub 8vjt49i uscovj8357g izuop xicubit w9ij ifjz ;oiub 8vjt49i uscovj8357g izuop xicubit w9ij ifjz ;oiub 8vjt49i uscovj8357g izuop xicubit w9ij ifjz ;oiub 8vjt49i uscovj8357g izuop xicubit w9ij ifjz ;oiub 8vjt49i uscovj8357g izuop xicubit w9ij ifjz ;oiub 8vjt49i uscovj8357g 8jdofi uv3w589t7 fujosdsfj v35"),
        NewsDataSource(author: "vlad", avatar: "FedericoBruno_Avatar", time: "19:32:22", likes: "9", comments: "0", text: "alskdfj alkdsj cibuoxp jbiwuet mvk zxclh; boimwei tng;zlkdfn biso;f vjoapkrw phviuzb"),
        NewsDataSource(author: "rina", avatar: "GulertAnastasia_Avatar", time: "1:23:24", likes: "92", comments: "0"),
        NewsDataSource(author: "borya", avatar: "TompsonAlisha_Avatar", time: "1:23:24", likes: "55", comments: "6", text: "alskdjf asdlkfj lksdjfa; lkjsdflka jsdlkfja ;lsdkjfiawojf lasdk fjaiwoj flasdkj oiwqj;p ifae f"),
        NewsDataSource(author: "yaroslav", avatar: "TomVekerfield_Avatar", time: "19:32:22", likes: "21", comments: "4"),
        NewsDataSource(author: "alexsander", avatar: "VictorMiheev_Avatar", time: "19:32:22", likes: "66", comments: "4"),
        NewsDataSource(author: "renat", avatar: "accecoriesAvatar", time: "1:23:24", likes: "45", comments: "3", text: "asflcb"),
        NewsDataSource(author: "violetta", avatar: "memsAvatar", time: "1:23:24", likes: "23", comments: "1"),
        NewsDataSource(author: "yana", avatar: "psychologyAvatar", time: "19:32:22", likes: "773", comments: "22", image: "images"),
        NewsDataSource(author: "andrey", avatar: "travelAvatar", time: "19:32:22", likes: "45", comments: "2")
    ]
    
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
    
}

// MARK: - UITableViewDataSource

extension NewsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
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
            
            cell.configure(news: news[indexPath.section])
            
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.reuseID,
                                                           for: indexPath) as? NewsCell else {
                return UITableViewCell()
            }
            
            cell.configure(news: news[indexPath.section])
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFooterCell.reuseID,
                                                           for: indexPath) as? NewsFooterCell else {
                return UITableViewCell()
            }
            
            cell.onLike = { [weak self] in
                // MARK: TODO: reuse of button and count of likes
                self?.news[indexPath.section].likeOrDislike()
            }
            
            cell.configure(news: news[indexPath.section])
            
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
            if let image = UIImage(named: news[indexPath.section].image ?? "") {
                let oldWidth = CGFloat(image.size.width)
                let oldHeight = CGFloat(image.size.height)
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
