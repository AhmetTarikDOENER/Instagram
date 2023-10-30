//
//  UIView+Extension.swift
//  Instagram
//
//  Created by Ahmet Tarik DÖNER on 30.10.2023.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
    
    public var width: CGFloat {
        frame.size.width
    }
    
    public var height: CGFloat {
        frame.size.height
    }
    
    public var top: CGFloat {
        frame.origin.y
    }
    
    public var bottom: CGFloat {
        top + height
    }
    
    public var left: CGFloat {
        frame.origin.x
    }
    
    public var right: CGFloat {
        left + width
    }
}
