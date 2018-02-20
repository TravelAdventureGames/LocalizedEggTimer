//
//  SponsorManager.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 20-02-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import UIKit

final class SponsorManager {

    static let shared = SponsorManager()

    func isSponsored() -> Bool {
        guard let locale = Locale.current.regionCode else { return false }
        switch locale {
        case "NL":
            return true
        default:
            return false
        }
    }
}
