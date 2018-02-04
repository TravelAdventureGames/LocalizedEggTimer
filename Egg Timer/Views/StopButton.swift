//
//  StopButton.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 04-02-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class StopButton: UIButton {

    let projectblue = UIColor(red: 0/255, green: 82/255, blue: 159/255, alpha: 1.0)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        commonInit()
    }

    private func commonInit() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderColor = projectblue.cgColor
        self.layer.borderWidth = 1
        self.layer.backgroundColor = UIColor.white.withAlphaComponent(0.65).cgColor
        self.setTitleColor(projectblue, for: .normal)
        self.setTitle("Stop", for: .normal)
        self.isEnabled = true
    }
}
