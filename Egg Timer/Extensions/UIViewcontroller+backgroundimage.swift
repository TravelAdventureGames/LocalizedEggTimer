//
//  UIViewcontroller+backgroundimage.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 21-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func setBackgroundWith(imageName: String) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: imageName)?.draw(in: self.view.bounds)

        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
    }
}
