//
//  ProfileTabsCollectionReusableView.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 1.11.2023.
//

import UIKit

class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let cellIdentifier = "ProfileTabsCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
