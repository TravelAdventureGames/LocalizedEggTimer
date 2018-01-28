//
//  CGFloat+multipliers.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 27-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    //Standard based on 6s (375 - 667)
    static func widthMultiplier() -> CGFloat {
        return UIScreen.main.bounds.width / 375
    }

    static func heightMultiplier() -> CGFloat {
        return UIScreen.main.bounds.height / 667
    }
}

