//
//  FriendsCell.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 03.08.2021.
//

import UIKit

final class FriendsCell: UITableViewCell {
    
    // MARK: - Static
    static let reuseID = "FriendsCell"
    
    // MARK: - Properties
    // Internal Properties
    internal var name: UILabel?
    internal var age: UILabel?
    internal var avatar: UIImageView?
    
    // Private Properties
    private var viewShadow: UIView?
    
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
        age = nil
        avatar = nil
    }
}

// MARK: - CellSetupDelegate
extension FriendsCell: CellSetupDelegate {
    func setupCell() {
        name = UILabel()
        age = UILabel()
        
        viewShadow = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        avatar = UIImageView(frame: viewShadow!.bounds)
        
        guard let name = name,
              let age = age,
              let avatar = avatar,
              let viewShadow = viewShadow else { return }
        
        name.font = .systemFont(ofSize: 17, weight: .semibold)
        name.textColor = R.color.blackWhite()
        
        age.font = .systemFont(ofSize: 13, weight: .thin)
        
        avatar.clipsToBounds = true
        avatar.layer.cornerRadius = 25
        
        viewShadow.clipsToBounds = false
        viewShadow.layer.shadowColor = UIColor.systemGray3.cgColor
        viewShadow.layer.shadowOpacity = 1
        viewShadow.layer.shadowOffset = CGSize.zero
        viewShadow.layer.shadowRadius = 10
        
        contentView.addSubview(name)
        contentView.addSubview(age)
        contentView.addSubview(viewShadow)
        viewShadow.addSubview(avatar)
    }
    
    func setupConstraints() {
        guard let name = name,
              let age = age,
              let avatar = avatar,
              let viewShadow = viewShadow else { return }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(10)
            $0.top.equalToSuperview().inset(10)
        }
        
        age.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        avatar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        viewShadow.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.leading.top.bottom.equalToSuperview().inset(10)
        }
    }
}
