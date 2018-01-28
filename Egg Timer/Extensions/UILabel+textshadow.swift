//
//  UILabel+textshadow.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 21-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func textDropShadow(color: UIColor) {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.4
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 1
    }

    static func createCustomLabel(color: UIColor) -> UILabel {
        let label = UILabel()
        label.textDropShadow(color: color)
        return label
    }
}
