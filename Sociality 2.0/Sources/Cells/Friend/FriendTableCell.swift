//
//  FriendsCell.swift
//  Sociality 2.0
//
//  Created by Антон Сивцов on 03.08.2021.
//

import UIKit
import Kingfisher

final class FriendTableCell: UITableViewCell {
    
    // MARK: - Static
    static let reuseID = "FriendsCell"
    
    // MARK: - Properties
    // Private Properties
    private var name: UILabel?
    private var age: UILabel?
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
extension FriendTableCell {
    func configure(friend: Friend) {
        guard let name = name,
              let age = age,
              let avatar = avatar else { return }
        name.text = friend.givenName + " " + friend.familyName
//        age.text = "\(friend.age) years"
        avatar.kf.setImage(with: URL(string: friend.avatar))


    }
    
}

// MARK: - CellSetupDelegate
extension FriendTableCell: TableViewCellSetupDelegate {
    func setupCell() {
        name = UILabel()
        age = UILabel()
        
        shadowView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        avatar = UIImageView()
        
        guard let name = name,
              let age = age,
              let avatar = avatar,
              let shadowView = shadowView else { return }
        
        name.font = .systemFont(ofSize: 17, weight: .semibold)
        name.textColor = R.color.blackWhite()
        
        age.font = .systemFont(ofSize: 13, weight: .thin)
        
        avatar.frame = shadowView.bounds
        
        setupShadow(avatar, shadowView)
        
        contentView.addSubview(name)
        contentView.addSubview(age)
        contentView.addSubview(shadowView)
        shadowView.addSubview(avatar)
    }
    
    func setupConstraints() {
        guard let name = name,
              let age = age,
              let avatar = avatar,
              let shadowView = shadowView else { return }
        
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
        
        shadowView.snp.makeConstraints {
            $0.width.height.equalTo(50)
            $0.leading.top.bottom.equalToSuperview().inset(10)
        }
    }

}
