//
//  NotificationFollowEventTableViewCell.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 2.11.2023.
//

import UIKit

protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: String)
}

class NotificationFollowEventTableViewCell: UITableViewCell {

    static let cellIdentifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        
        
        return button
    }()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubviews(profileImageView, label, followButton)
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
    
    public func configure(with model: String) {
        
    }
    
}
