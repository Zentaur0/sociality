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
    internal var name: UILabel?
    internal var age: UILabel?
    internal var avatar: UIImageView?
    
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
        avatar = UIImageView()
        
        guard let name = name,
              let age = age,
              let avatar = avatar else { return }
        
        name.font = .systemFont(ofSize: 17, weight: .bold)
        
        age.font = .systemFont(ofSize: 13, weight: .thin)
        
        avatar.layer.cornerRadius = 20
        
        addSubview(name)
        addSubview(age)
        addSubview(avatar)
    }
    
    func setupConstraints() {
        guard let name = name,
              let age = age,
              let avatar = avatar else { return }
        
        name.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(5)
            $0.top.equalToSuperview().inset(5)
        }
        
        age.snp.makeConstraints {
            $0.leading.equalTo(avatar.snp.trailing).offset(5)
            $0.bottom.equalToSuperview().inset(5)
        }
        
        avatar.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.leading.top.bottom.equalToSuperview().inset(5)
        }
    }
}
