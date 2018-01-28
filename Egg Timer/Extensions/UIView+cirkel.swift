//
//  UIView+cirkel.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 21-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func makeCirculair(borderColor: UIColor, borderWidth: CGFloat) {
        self.layer.cornerRadius = self.frame.width / 2
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = true
    }

    func roundedCorners(radius: CGFloat, borderColor: UIColor?, borderWidth: CGFloat?) {
        self.layer.cornerRadius = radius
        guard let color = borderColor else { return }
        guard let width = borderWidth else { return }
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
}
