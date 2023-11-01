//
//  ProfileInfoHeaderCollectionReusableView.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 1.11.2023.
//

import UIKit

class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let cellIdentifier = "ProfileInfoHeaderCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBlue
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
