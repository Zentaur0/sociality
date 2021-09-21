//
//  NewsFooterView.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 14.09.2021.
//

import UIKit

// MARK: - NewsFooterView

final class NewsFooterCell: UITableViewCell {
    
    // MARK: - Static
    
    static let reuseID = "NewsFooterCell"
    
    // MARK: - Properties
    
    var onLike: (() -> Void)?
    private let likeButton = UIButton(type: .system)
    private let likeCountLabel = UILabel()
    private let commentButton = UIButton(type: .system)
    private let commentCountLabel = UILabel()
    private var isLiked = false
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        likeCountLabel.text = nil
        commentCountLabel.text = nil
    }
    
}

// MARK: - Methods

extension NewsFooterCell {
    
    func configure() {
        let news = NewsDataSource(author: "vlad", avatar: "FedericoBruno_Avatar", time: "19:32:22", likes: "9", comments: "0", text: "alskdfj alkdsj cibuoxp jbiwuet mvk zxclh; boimwei tng;zlkdfn biso;f vjoapkrw phviuzb")
        likeCountLabel.text = news.likes
        commentCountLabel.text = news.comments
    }
    
    private func setupCell() {
        selectionStyle = .none
        
        likeButton.setBackgroundImage(R.image.disliked(), for: .normal)
        likeButton.addTarget(self, action: #selector(likeOrDislike), for: .touchUpInside)
        likeCountLabel.text = "0"
        
        backgroundColor = .white
        
        contentView.addSubview(likeButton)
        contentView.addSubview(likeCountLabel)
    }
    
    private func setupConstraints() {
        likeButton.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(15)
            $0.width.equalTo(likeButton.snp.height)
        }
        
        likeCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(likeButton.snp.trailing).offset(10)
        }
    }
    
}

// MARK: - Actions

extension NewsFooterCell {
    
    @objc private func likeOrDislike() {
        isLiked = !isLiked
        likeButton.setBackgroundImage(isLiked ? R.image.liked() : R.image.disliked(), for: .normal)
        if let text = likeCountLabel.text, var number = Int(text) {
            number = isLiked ? number + 1 : number - 1
            likeCountLabel.text = String(number)
        }
        onLike?()
    }
    
}
