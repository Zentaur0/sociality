//
//  NewsHeaderView.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 14.09.2021.
//

import UIKit

// MARK: - NewsHeader

final class NewsHeaderCell: UITableViewCell {
    
    // MARK: - Static
    
    static let reuseID = "NewsHeaderCell"
    
    // MARK: - Properties
    
    private let authorImageView = UIImageView()
    private let nameLabel = UILabel()
    private let timeLabel = UILabel()
    private let closeButton = UIButton(type: .system)
    private let dateFormatter: DateFormatter = {
        let formater = DateFormatter()
        formater.dateFormat = "dd-MMM hh:mm"
        return formater
    }()
    
    private lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, timeLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
    }()
    
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
        timeLabel.text = nil
        nameLabel.text = nil
    }
    
}

// MARK: - Methods

extension NewsHeaderCell {
    
    func configure(model: GroupModel) {
        authorImageView.kf.setImage(with: URL(string: model.photo))
        nameLabel.text = model.name
        timeLabel.text = dateFormatter.string(from: Date(timeIntervalSince1970: model.date))
    }
    
    private func setupCell() {
        selectionStyle = .none
        
        timeLabel.textColor = .lightGray
        
        authorImageView.clipsToBounds = true
        authorImageView.layer.cornerRadius = 20
        authorImageView.layer.borderColor = UIColor.gray.cgColor
        authorImageView.layer.borderWidth = 0.5
        
        closeButton.setBackgroundImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .darkText
        
        backgroundColor = .white
        contentView.addSubview(authorImageView)
        contentView.addSubview(labelStack)
        contentView.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        authorImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(authorImageView.snp.height)
        }
        
        labelStack.snp.makeConstraints {
            $0.leading.equalTo(authorImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(closeButton.snp.leading).inset(10)
            $0.centerY.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(18)
            $0.trailing.equalToSuperview().inset(10)
            $0.width.equalTo(closeButton.snp.height)
        }
    }
    
}
