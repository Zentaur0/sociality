//
//  NewsCell.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 14.09.2021.
//

import UIKit

// MARK: - NewsCell

final class NewsCell: UITableViewCell {
    
    // MARK: - Static
    
    static let reuseID = "NewsCell"
    
    // MARK: - Properties
    
    var textHeight = CGFloat()
    var imageHeight = CGFloat()
    private let newsImageView = UIImageView()
    private let newsTextLabel = UILabel()
    private let expandableButton = UIButton(type: .system)
    private var isExpanded = false
    var onButton: EmptyClosure?
    
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
        newsImageView.image = nil
        newsTextLabel.text = nil
    }
    
}

// MARK: - Methods

extension NewsCell {
    
    func configure(news: ItemsModel) {
        if let photoURL = news.photoURL {
            newsImageView.kf.setImage(with: URL(string: photoURL))
            imageHeight = CGFloat(news.aspectRatio)
        }
        if let text = news.text {
            newsTextLabel.text = text
            
            if text.count > 200 {
                expandableButton.isHidden = false
            }
        }
    }
    
    private func setupCell() {
        selectionStyle = .none
        
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        
        newsTextLabel.lineBreakMode = .byTruncatingTail
        newsTextLabel.numberOfLines = 6
        
        expandableButton.setTitle("Show more", for: .normal)
        expandableButton.addTarget(self, action: #selector(expandableButtonTapped), for: .touchUpInside)
        expandableButton.isHidden = true
        textHeight = newsTextLabel.intrinsicContentSize.height
        
        contentView.addSubview(newsTextLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(expandableButton)
    }
    
    private func setupConstraints() {
        newsTextLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
        }
        
        newsImageView.snp.makeConstraints {
            $0.top.equalTo(expandableButton.snp.bottom).offset(5)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        expandableButton.snp.makeConstraints {
            $0.top.equalTo(newsTextLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
        }
    }
    
}

// MARK: - Actions

extension NewsCell {
    
    @objc private func expandableButtonTapped() {
        isExpanded = !isExpanded
        let showMore = "Show more"
        let showLess = "Show less"
        
        expandableButton.setTitle(isExpanded ? showLess : showMore, for: .normal)
        newsTextLabel.numberOfLines = isExpanded ? 0 : 6
        
        textHeight = isExpanded ? newsTextLabel.intrinsicContentSize.height : 0
        
        onButton?()
    }
    
}
