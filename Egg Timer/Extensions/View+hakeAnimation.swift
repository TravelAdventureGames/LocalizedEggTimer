//
//  View+hakeAnimation.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 23-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-4.0, 4.0, -4.0, 4.0, -2.0, 2.0, -1.0, 1.0, 0.0 ]
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: "shake")
    }

}
