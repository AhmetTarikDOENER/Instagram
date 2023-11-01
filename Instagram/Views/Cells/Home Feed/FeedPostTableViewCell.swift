//
//  FeedPostTableViewCell.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 1.11.2023.
//

import UIKit

final class FeedPostTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "FeedPostTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure() {
        
    }
    
}

