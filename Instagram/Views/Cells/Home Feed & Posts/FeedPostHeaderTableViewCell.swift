//
//  HomeFeedTableViewCell.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 1.11.2023.
//

import UIKit
import SDWebImage

protocol FeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}

class FeedPostHeaderTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "FeedPostHeaderTableViewCell"
    
    weak var delegate: FeedPostHeaderTableViewCellDelegate?
    
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        
        return button
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(profilePhotoImageView, usernameLabel, moreButton)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size = contentView.height - 4
        profilePhotoImageView.frame = CGRect(x: 2, y: 2, width: size, height: size)
        profilePhotoImageView.layer.cornerRadius = size / 2
        
        moreButton.frame = CGRect(x: contentView.width - size, y: 2, width: size, height: size)
        
        usernameLabel.frame = CGRect(x: profilePhotoImageView.right + 10, y: 2, width: contentView.width - (size * 2) - 15, height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        usernameLabel.text = nil
        profilePhotoImageView.image = nil
    }
    
    //MARK: - Private
    
    @objc private func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
    
    
    //MARK: - Public
    
    public func configure(with model: User) {
        usernameLabel.text = model.username
        profilePhotoImageView.image = UIImage(systemName: "person.circle")
//        profilePhotoImageView.sd_setImage(with: model.profilePhoto, completed: nil)
    }
    
}
