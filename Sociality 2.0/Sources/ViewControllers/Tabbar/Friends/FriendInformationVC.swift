//
//  FriendInformationVC.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit
import Kingfisher
import RealmSwift

final class FriendInformationVC: UIViewController {
    
    // MARK: - Properties
    // Internal Properties
    internal var friend: Friend
    private var photos: [Photo] = []
    
    // Private Properties
    private var collectionView: UICollectionView?
    
    // MARK: - Init
    init(friend: Friend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle   
    override func viewDidLoad() {
        super.viewDidLoad()
        provideFriendPhotos()
        setupVC()
        setupConstraints()
    }

}

// MARK: - Methods
extension FriendInformationVC {
    private func setupVC() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

        guard let collectionView = collectionView else { return }

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FriendCollectionCell.self, forCellWithReuseIdentifier: FriendCollectionCell.reuseID)

        collectionView.backgroundColor = R.color.whiteBlack()

        view.addSubview(collectionView)

        title = friend.givenName + " " + friend.familyName
    }

    private func setupConstraints() {
        guard let collectionView = collectionView else { return }

        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func provideFriendPhotos() {
        let realmCheck: [Photo] = NetworkManager.shared.readPhotosFromRealm(ownerID: friend.id)
        if realmCheck.isEmpty {
            NetworkManager.shared.loadFriendsPhotos(ownerID: String(friend.id), friend: friend) { [weak self] result in
                switch result {
                case .success(let photos):
                    self?.photos = photos
                    DispatchQueue.main.async { [weak self] in
                        self?.collectionView?.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            photos = realmCheck
        }
        
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

        cell.config(friend: friend, photos: photos, for: indexPath)
        
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
        return view.sizeThatFits(CGSize(width: view.frame.width - 50, height: 100))
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }

}
