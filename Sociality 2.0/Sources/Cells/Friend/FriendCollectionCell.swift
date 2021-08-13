//
//  FriendCollectionCell.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit

final class FriendCollectionCell: UICollectionViewCell {
    
    // MARK: - Static
    static let reuseID = "FriendCollectionCell"
    
    // MARK: - Properties
    // Internal Properties
    private var imageView: UIImageView?
    private var infoLabel: UILabel?
    private var likeControll: UIImageView?
    private var likeCountLabel: UILabel?
    private var shadowView: UIView?
    
    // Private Properties
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.layer.cornerRadius = 5
        stack.layer.masksToBounds = true
        stack.layer.borderColor = UIColor.black.cgColor
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
        setupConstraints()
    }

    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: - Methods
extension FriendCollectionCell {
    func config(friend: Friend, for indexPath: IndexPath) {
        guard let imageView = imageView,
              let infoLabel = infoLabel,
              let likeControll = likeControll,
              let likeCountLabel = likeCountLabel else { return }
//        imageView.image = UIImage(named: friend.ava[indexPath.item])
        infoLabel.text = friend.familyName
//        likeControll
//        likeCountLabel
    }
}

// MARK: - CollectionViewCellSetupDelegate
extension FriendCollectionCell: CollectionViewCellSetupDelegate {
    func setupCell() {
        imageView = UIImageView()
        infoLabel = UILabel()
        likeControll = UIImageView()
        likeCountLabel = UILabel()
        shadowView = UIView()
        
        guard let imageView = imageView,
              let infoLabel = infoLabel,
              let likeControll = likeControll,
              let likeCountLabel = likeCountLabel,
              let shadowView = shadowView else { return }
        
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        
        likeCountLabel.text = "0"
        likeControll.image = R.image.disliked()
        let view = UIView()
        view.backgroundColor = R.color.whiteBlack()
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        
        contentView.addSubview(shadowView)
        contentView.addSubview(view)
        view.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(3)
        }
        setupShadow(imageView, shadowView)
        
        bottomStackView = UIStackView(arrangedSubviews: [infoLabel, likeCountLabel, likeControll])
        bottomStackView.backgroundColor = .white
        
        contentMode = .scaleAspectFit
        view.addSubview(imageView)
        view.addSubview(bottomStackView)
    }
    
    func setupConstraints() {
        guard let imageView = imageView,
              let likeControll = likeControll,
              let likeCountLabel = likeCountLabel,
              let shadowView = shadowView else { return }
        
        bottomStackView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(3)
            $0.height.equalTo(30)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.equalTo(bottomStackView.snp.top).offset(-10)
            $0.top.leading.trailing.equalToSuperview()
        }
        
        likeControll.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }
        
        likeCountLabel.snp.makeConstraints {
            $0.width.height.equalTo(20)
        }
        
        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupShadow(_ avatar: UIImageView, _ shadowView: UIView) {
        shadowView.clipsToBounds = false
        shadowView.layer.shadowColor = UIColor.systemGray4.cgColor
        shadowView.layer.shadowOpacity = 1
        shadowView.layer.shadowOffset = CGSize.zero
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 5,
                                                                       y: 5,
                                                                       width: contentView.frame.width,
                                                                       height: contentView.frame.height),
                                                   cornerRadius: 5).cgPath
    }

}
