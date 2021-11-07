//
//  GroupCell.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit
import Kingfisher

// MARK: - GroupCell

final class GroupCell: UITableViewCell {
    
    // MARK: - Static
    
    static let reuseID = "GroupCell"
    
    // MARK: - Properties
    
    // Private Properties
    private var name: UILabel?
    private var avatar: UIImageView?
    private var shadowView: UIView?
    
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

}

// MARK: - Methods

extension GroupCell {
    
    func configure(group: Group) {
        name?.text = group.nickname
        avatar?.kf.setImage(with: URL(string: group.avatar))
    }
    
}

// MARK: - CellSetupDelegate

extension GroupCell: TableViewCellSetupDelegate {
    
    func setupCell() {
        name = UILabel()
        avatar = UIImageView()
        shadowView = UIView()
        
        guard let name = name,
              let avatar = avatar,
              let shadowView = shadowView else { return }
        
        name.font = .friendNameFont
        name.textColor = R.color.blackWhite()
        name.numberOfLines = 0
        
        setupShadow(avatar, shadowView)
        
        contentView.addSubview(name)
        contentView.addSubview(shadowView)
        shadowView.addSubview(avatar)
        
    }
    
    func setupConstraints() {
        guard let name = name,
              let avatar = avatar,
              let shadowView = shadowView else { return }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(10)
            $0.top.trailing.equalToSuperview().inset(10)
        }
        
        avatar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        shadowView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.leading.bottom.equalToSuperview().inset(10)
        }
    }
    
}
