//
//  BolingtimeCalculator.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 22-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation
import Darwin

class BoilingtimeCalculator {

    static let shared = BoilingtimeCalculator()

    //Meet omtrek vh ei
    private func c2(egg: Egg) -> Double {
        switch egg.size {
        case .Small:
            return pow((12.0 / .pi), 2)
        case .Medium:
            return pow((14.0 / .pi), 2)
        case .Large:
            return pow((16.0 / .pi), 2)
        }
    }

    private func Tegg(egg: Egg) -> Double {
        switch egg.roomTemp {
        case true:
            return 18
        case false:
            return 5
        }
    }

    private func TWater(egg:Egg) -> Double {
        let altitude = egg.altitude
        let tempReduction = Double(altitude / 150) * 0.5
        return 100 - tempReduction
    }

    
    private func TYolk(egg: Egg) -> Double {
        switch egg.desiredEggType {
        case .Soft:
            return 60.0
        case .SoftMedium:
            return 66.4
        case .Medium:
            return 71.6
        case .MediumHard:
            return 76.2
        case .Hard:
            return 84.2
        }
    }

    func calculatedBoilingtime(egg: Egg) -> Int {

        let teller = 2.0*(TWater(egg: egg) - Tegg(egg: egg))
        let noemer = TWater(egg: egg) - TYolk(egg: egg)
        let breuk = teller / noemer
        let ln = log(breuk)
        let c = c2(egg: egg)

        let t = 0.15 * c * ln
        let tsec = t*60

        return Int(tsec)
    }
}
