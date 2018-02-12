//
//  Egg.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 20-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation

enum CurrentCountry: String {
    case US
    case ElseWhere
}

enum EggSize {
    case Small
    case Medium
    case Large
    case XLJumbo

}

enum EggType {
    case Soft
    case SoftMedium
    case Medium
    case MediumHard
    case Hard

    var place: Int {
        switch self {
        case .Soft:
            return 0
        case .SoftMedium:
            return 1
        case .Medium:
            return 2
        case .MediumHard:
            return 3
        case .Hard:
            return 4
        }
    }

    var nameMultiple: String {
        switch self {
        case .Soft:
            return "model.druiperige.eieren".localized
        case .SoftMedium:
            return "model.zachte.eieren".localized
        case .Medium:
            return "model.medium.eieren".localized
        case .MediumHard:
            return "model.mh.eieren".localized
        case .Hard:
            return "model.harde.eieren".localized
        }
    }
    var nameSingle: String {
        switch self {
        case .Soft:
            return "model.druiperig.ei".localized
        case .SoftMedium:
            return "model.zacht.ei".localized
        case .Medium:
            return "model.medium.ei".localized
        case .MediumHard:
            return "model.mh.ei".localized
        case .Hard:
            return "model.hard.ei".localized
        }
    }
}

struct Egg {
    let roomTemp: Bool
    let size: EggSize
    let desiredEggType: EggType
    let amount: Int
    let altitude: Int
    let currentCountry: CurrentCountry
}
