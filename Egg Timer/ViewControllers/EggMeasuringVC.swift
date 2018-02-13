//
//  EggMeasuringVC.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 13-02-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import UIKit

class EggMeasuringVC: UIViewController {

    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var eggMeasureImageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func didClickCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
