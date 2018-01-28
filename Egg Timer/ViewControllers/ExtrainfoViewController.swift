//
//  ExtrainfoViewController.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 26-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class ExtrainfoViewController: UIViewController {
    @IBOutlet var infoTextLabel: UILabel!
    
    let infoText = "extrainfovc.label.text".localized

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundWith(imageName: "snowboard8")
        title = "Tips"

        let attributees = [NSAttributedStringKey.foregroundColor: UIColor.white, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16*CGFloat.widthMultiplier())]
        let string = infoText
        infoTextLabel.attributedText = NSAttributedString(html: string, fontAttributes: attributees)
    }
}
