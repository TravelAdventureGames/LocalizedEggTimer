//
//  FriendsOfLabel.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 20-02-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class FriendsOfLabel: UILabel {

    let color = UIColor.projectBlueWith(alpha: 1)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7
        self.textColor = color
        self.numberOfLines = 0
        self.layer.masksToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
