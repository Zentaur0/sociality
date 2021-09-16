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
    
    private let newsImageView = UIImageView()
    private let newsTextLabel = UILabel()
    
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
    
    func configure(news: NewsDataSource) {
        if let image = news.image {
            newsImageView.image = UIImage(named: image)
//        newsImageView.kf.setImage(with: URL(string: News.self))
        }
        if let text = news.text {
            newsTextLabel.text = text
        }
    }
    
    private func setupCell() {
        selectionStyle = .none
        
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        
        newsTextLabel.numberOfLines = 0
        
        contentView.addSubview(newsTextLabel)
        contentView.addSubview(newsImageView)
    }
    
    private func setupConstraints() {
        newsTextLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(10)
            $0.bottom.equalTo(newsImageView.snp.top).offset(-5)
        }
        
        newsImageView.snp.makeConstraints {
            $0.height.equalToSuperview().priority(.low)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
