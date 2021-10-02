//
//  FriendCollectionCell.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit
import Kingfisher

// MARK: - FriendCollectionCell

final class FriendCollectionCell: UICollectionViewCell {
    
    // MARK: - Static
    
    static let reuseID = "FriendCollectionCell"
    
    // MARK: - Properties
    
    // Internal Properties
    
    var onLike: (() -> Void)?
    
    // Private Properties
    
    private var imageView: UIImageView?
    private var infoLabel: UILabel?
    private var likeControll: UIButton?
    private var likeCountLabel: UILabel?
    private var shadowView: UIView?
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.layer.cornerRadius = 5
        stack.layer.masksToBounds = true
        stack.distribution = .fillProportionally
        stack.layer.borderColor = UIColor.black.cgColor
        return stack
    }()
    
    private var size: CGSize?
    private var isLiked = false
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
    }
    
}

// MARK: - Methods

extension FriendCollectionCell {
    
    func config(friend: Friend, for indexPath: IndexPath) {
        guard let imageView = imageView,
              let infoLabel = infoLabel,
              let likeControll = likeControll,
              let likeCountLabel = likeCountLabel else { return }
        let photos = Array(friend.images)
        imageView.kf.setImage(with: URL(string: photos[indexPath.row].imageURL))
        infoLabel.text = friend.familyName
        likeControll.setBackgroundImage(R.image.disliked() ?? R.image.liked(), for: .normal)
        likeCountLabel.text = String(photos[indexPath.row].likes)
    }
    
    private func setupCell() {
        imageView = UIImageView()
        infoLabel = UILabel()
        likeControll = UIButton(type: .system)
        likeCountLabel = UILabel()
        shadowView = UIView()

        guard let imageView = imageView,
              let infoLabel = infoLabel,
              let likeControll = likeControll,
              let likeCountLabel = likeCountLabel,
              let shadowView = shadowView else { return }

        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = sizeThatFits(CGSize(width: frame.width - 30, height: frame.width))
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.contentMode = .scaleAspectFill
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)

        likeCountLabel.textAlignment = .right
        likeControll.setBackgroundImage(R.image.disliked(), for: .normal)
        likeControll.addTarget(self, action: #selector(likeTap), for: .touchUpInside)

        shadowView.layer.borderColor = UIColor.gray.withAlphaComponent(0.6).cgColor
        shadowView.layer.borderWidth = 0.5
        shadowView.layer.cornerRadius = 5
        
        bottomStackView = UIStackView(arrangedSubviews: [infoLabel, likeCountLabel, likeControll])
        bottomStackView.setCustomSpacing(10, after: likeCountLabel)
        bottomStackView.setCustomSpacing(10, after: likeControll)
        bottomStackView.backgroundColor = .white

        contentMode = .scaleAspectFit
        contentView.addSubview(shadowView)
        shadowView.addSubview(imageView)
        shadowView.addSubview(bottomStackView)
    }

    private func setupConstraints() {
        guard let imageView = imageView,
              let likeControll = likeControll,
              let likeCountLabel = likeCountLabel,
              let shadowView = shadowView else { return }

        bottomStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(3)
            $0.trailing.leading.equalToSuperview().inset(7)
            $0.height.equalTo(30)
            $0.top.equalTo(imageView.snp.bottom).offset(10)
        }

        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().priority(999)
        }

        likeControll.snp.makeConstraints {
            $0.width.height.equalTo(30)
        }

        likeCountLabel.snp.makeConstraints {
            $0.width.equalTo(50)
        }

        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}

// MARK: - Actions

extension FriendCollectionCell {
    
    @objc private func likeTap() {
        onLike?()
        isLiked = !isLiked
        likeControll?.setBackgroundImage(isLiked ? R.image.liked() : R.image.disliked(), for: .normal)
        if let text = likeCountLabel?.text, var number = Int(text) {
            number = isLiked ? number + 1 : number - 1
            likeCountLabel?.text = String(number)
        }
    }

}
