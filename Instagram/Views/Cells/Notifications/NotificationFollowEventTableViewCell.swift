//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 2.11.2023.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: UserNotification)
}

class NotificationFollowEventTableViewCell: UITableViewCell {

    static let cellIdentifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .tertiarySystemBackground
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@elonmusk followed you."
        
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        
        return button
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubviews(profileImageView, label, followButton)
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
        configureForFollow()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubviews(profileImageView, label, followButton)
        
        profileImageView.frame = CGRect(
            x: 3,
            y: 3,
            width: contentView.height - 6,
            height: contentView.height - 6
        )
        profileImageView.layer.cornerRadius = profileImageView.height / 2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(
            x: contentView.width - 5 - size,
            y: (contentView.height - 44) / 2,
            width: size,
            height: buttonHeight
        )
        
        label.frame = CGRect(
            x: profileImageView.right + 5,
            y: 0,
            width: contentView.width - size - profileImageView.width - 16,
            height: contentView.height
        )
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    
    //MARK: - Public
    
    public func configure(with model: UserNotification) {
        self.model = model
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            // configure button
            switch state {
            case .following:
                // Show unfollow button
                configureForFollow()
            case .not_following:
                // Show follow button
                configureForUnfollow()
            }
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto)
    }
    
    
    //MARK: - Action
    
    @objc private func didTapFollowButton() {
        guard let model = model else { return }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    
    //MARK: - Private
    
    private func configureForFollow() {
        followButton.setTitle("Unfollow", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
    }
    
    private func configureForUnfollow() {
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.white, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = .link
    }
    
    
}
