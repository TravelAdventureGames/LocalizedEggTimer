//
//  GradientImageview.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 29-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class GradientImageView: UIImageView {

    // MARK: Properties

    private var gradientLayer = CAGradientLayer()

    var colors: [CGColor] = [UIColor.clear.cgColor, UIColor.white.cgColor] {
        didSet {
            gradientLayer.colors = colors
        }
    }

    var startPoint = CGPoint.zero {
        didSet {
            gradientLayer.startPoint = startPoint
        }
    }

    var endPoint = CGPoint(x: 0, y: 1) {
        didSet {
            gradientLayer.endPoint = endPoint
        }
    }

    // MARK: Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        layer.addSublayer(gradientLayer)
    }

    // MARK: Layout

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = bounds
    }

}

