//
//  NotificationLikeEventTableViewCell.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 2.11.2023.
//

import UIKit

protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostsButton(model: String)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
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
    
    private let postButton: UIButton = {
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
        contentView.addSubviews(profileImageView, label, postButton)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    
    //MARK: - Public
    
    public func configure(with model: String) {
        
    }
}
