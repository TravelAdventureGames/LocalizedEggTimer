//
//  PaddingLabel.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 20-02-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

class Paddinglabel: UILabel {
    let padding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
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
