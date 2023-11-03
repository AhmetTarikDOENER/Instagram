//
//  FeedPostTableViewCell.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 1.11.2023.
//

import UIKit
import SDWebImage
import AVFoundation

/// Call for primary post content
final class FeedPostTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "FeedPostTableViewCell"
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true // Doesnt over flow any of its content out of the image
        
        return imageView
    }()
    
    private var player: AVPlayer?
    
    private var playerLayer = AVPlayerLayer()
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layer.addSublayer(playerLayer) // Important to add layer first
        contentView.addSubviews(postImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = contentView.bounds
        postImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    public func configure(with post: UserPost) {
        postImageView.image = UIImage(named: "testImage")
        
        return
        
//        switch post.postType {
//        case .photo:
//            // Show image
//            postImageView.sd_setImage(with: post.postURL, completed: nil)
//        case .video:
//            // Load and play video
//            player = AVPlayer(url: post.postURL)
//            playerLayer.player = player
//            playerLayer.player?.volume = 0
//            playerLayer.player?.play()
//        }
    }
    
}

