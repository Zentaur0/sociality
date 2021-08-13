//
//  GroupCell.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 04.08.2021.
//

import UIKit

final class GroupCell: UITableViewCell {
    
    // MARK: - Static
    static let reuseID = "GroupCell"
    
    // MARK: - Properties
    // Internal Properties
    internal var name: UILabel?
    internal var avatar: UIImageView?
    
    // Private Properties
    private var shadowView: UIView?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
        setupConstraints()
    }
    
    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()
        name = nil
        avatar = nil
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
        
        name.font = .systemFont(ofSize: 17, weight: .semibold)
        name.textColor = R.color.blackWhite()
        
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
            $0.top.equalToSuperview().inset(10)
        }
        
        avatar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        shadowView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.leading.top.bottom.equalToSuperview().inset(10)
        }
    }
}
