//
//  UIView+Extention.swift
//  Dcoder Clone
//
//  Created by Hemant Gore on 01/02/20.
//  Copyright © 2020 Dream Big. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 6
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
    }
    
    func setCornerRadius(to value: CGFloat) {
//        self.layer.masksToBounds = true
        self.layer.cornerRadius = value
    }
    
    func setAnchors(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero) {
        
    }
}
