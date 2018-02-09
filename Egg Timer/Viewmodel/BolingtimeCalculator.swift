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
    func c2(egg: Egg) -> Double {
        switch (egg.size, egg.currentCountry) {
        case (.Small, .ElseWhere):
            return pow((14.9 / .pi), 2)
        case (.Medium, .ElseWhere):
            return pow((15.3 / .pi), 2)
        case (.Large, .ElseWhere):
            return pow((15.7 / .pi), 2)
        case (.XLJumbo, .ElseWhere):
            return pow((16.0 / .pi), 2)

        case (.Small, .US):
            return pow((14.7 / .pi), 2)
        case (.Medium, .US):
            return pow((15.1 / .pi), 2)
        case (.Large, .US):
            return pow((15.5 / .pi), 2)
        case (.XLJumbo, .US):
            return pow((15.7 / .pi), 2)
        }
    }

    //USA: Jumbo: 70.9, XL: 63.8, L: 56.7, M: 49.6, S: 42.5
    //Canada: Jumbo: 70, XL: 63, L: 56, M: 49, S: 42
    //EU: XL: 73, L: 63, M: 53, S: < 53

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
            return 64
        case .SoftMedium:
            return 70.4
        case .Medium:
            return 76.0
        case .MediumHard:
            return 82.2
        case .Hard:
            return 88.2
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
        print("The cooking time is \(tsec)")
        return Int(tsec)
    }
}
