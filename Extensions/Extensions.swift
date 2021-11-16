//
//  Extensions.swift
//  training
//
//  Created by Olesya Nikolaeva on 16.11.2021.
//  Copyright © 2021 Olesya Nikolaeva. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 1.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }

    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
}

extension UIStackView {
    func addBackground(bgColor: UIColor, borderColor: UIColor, borderWidth: CGFloat, radiusSize: CGFloat, opacity: Float = 0.6) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = bgColor
        subView.layer.opacity = opacity
        
        subView.layer.borderWidth = borderWidth
        subView.layer.borderColor = borderColor.cgColor
        subView.layer.cornerRadius = radiusSize
        
        subView.layer.shadowColor = UIColor.systemGray.cgColor
        subView.layer.shadowRadius = 3.0
        subView.layer.shadowOpacity = 1.0
        subView.layer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        insertSubview(subView, at: 0)
    }
}
