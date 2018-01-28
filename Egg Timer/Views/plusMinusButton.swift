//
//  plusMinusButton.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 20-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class plusMinusButton: UIButton {

    let color = UIColor.black.cgColor

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        self.layer.borderColor = color
        self.layer.borderWidth = 1
        self.setTitleColor(.black, for: .normal)
    }

}
