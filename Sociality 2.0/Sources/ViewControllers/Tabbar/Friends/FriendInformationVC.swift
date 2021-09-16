//
//  FriendInformationVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit
import Kingfisher
import RealmSwift

// MARK: - FriendInformationVC

final class FriendInformationVC: UIViewController {
    
    // MARK: - Properties
    
    var friend: Friend
    private let refreshControll = UIRefreshControl()
    private var notificationToken: NotificationToken?
    private var collectionView: UICollectionView?
    
    // MARK: - Init
    
    init(friend: Friend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
        provideFriendPhotos()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        setupConstraints()
    }
    
}

// MARK: - Methods

extension FriendInformationVC {
    
    private func setupVC() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        guard let collectionView = collectionView else { return }

        refreshControll.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        collectionView.refreshControl = refreshControll
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FriendCollectionCell.self, forCellWithReuseIdentifier: FriendCollectionCell.reuseID)

        collectionView.backgroundColor = R.color.whiteBlack()

        view.addSubview(collectionView)
        view.backgroundColor = R.color.whiteBlack()

        title = friend.givenName + " " + friend.familyName
    }

    private func setupConstraints() {
        guard let collectionView = collectionView else { return }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func provideFriendPhotos() {
        let realmCheck: [Photo] = RealmManager.shared.readPhotosFromRealm(ownerID: self.friend.id)
        if realmCheck.isEmpty {
            self.fetchData()
        } else {
            if friend.images.isEmpty {
                for image in realmCheck {
                    self.friend.images.append(image)
                }
            }
        }
    }
    
    private func notificate() {
        do {
            let realm = try Realm()
            let realmObject = realm.objects(Friend.self)
            notificationToken = realmObject.observe { (change: RealmCollectionChange) in
                switch change {
                case .error(let error):
                    print(error)
                case .initial(_):
                    self.collectionView?.reloadData()
                case let .update(_, deletions, insertions, modifications):
                    self.collectionView?.performBatchUpdates({
                    self.collectionView?.insertItems(at: insertions.map({ IndexPath(row: $0, section: 0) }))
                    self.collectionView?.deleteItems(at: deletions.map({ IndexPath(row: $0, section: 0)}))
                    self.collectionView?.reloadItems(at: modifications.map({ IndexPath(row: $0, section: 0) }))
                }, completion: nil)
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func fetchData() {
        NetworkManager.shared.loadFriendsPhotos(friend: friend) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

}

// MARK: - Actions

extension FriendInformationVC {
    
    @objc func refresh() {
        provideFriendPhotos()
        notificate()
        refreshControll.endRefreshing()
    }
    
}

// MARK: - UICollectionViewDataSource

extension FriendInformationVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        friend.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendCollectionCell.reuseID,
                                                            for: indexPath) as? FriendCollectionCell else {
            return UICollectionViewCell()
        }
        
        cell.config(friend: friend, for: indexPath)
        
        return cell
    }

}

// MARK: - UICollectionViewDelegate

extension FriendInformationVC: UICollectionViewDelegate {}

// MARK: - UICollectionViewDelegateFlowLayout

extension FriendInformationVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let oldWidth = CGFloat(friend.images[indexPath.item].width)
        let oldHeight = CGFloat(friend.images[indexPath.item].height)
        let scaleFactor = view.frame.width / oldWidth
        let newHeight = CGFloat(oldHeight) * scaleFactor
        let size = CGSize(width: view.frame.width - 50, height: newHeight)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

}
