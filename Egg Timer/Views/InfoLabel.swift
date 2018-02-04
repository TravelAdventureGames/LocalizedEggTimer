//
//  InfoLabel.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 01-02-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class InfoLabel: UILabel {

    let padding = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, padding))
    }

    override var intrinsicContentSize : CGSize {
        let superContentSize = super.intrinsicContentSize
        let width = superContentSize.width + padding.left + padding.right
        let heigth = superContentSize.height + padding.top + padding.bottom
        return CGSize(width: width, height: heigth)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.numberOfLines = 0
        self.backgroundColor = UIColor.projectBlueWith(alpha: 0.8)
        self.layer.masksToBounds = true

        let attributees = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 15 * CGFloat.widthMultiplier())]
        let string = "infolabel.label.infotext".localized
        self.attributedText = NSAttributedString(html: string, fontAttributes: attributees)
    }
}
