//
//  UILabel+padding.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 23-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

class UILabelPadding: UILabel {

    let padding = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }

    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }
}
