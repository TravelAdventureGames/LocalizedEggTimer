//
//  UserdefaultsManager.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 31-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation

class UserdefaultManager {
    static var secondLaunch: Bool {
        get { return UserDefaults.standard.bool(forKey: "secondlaunch") }
        set { UserDefaults.standard.set(newValue, forKey: "secondlaunch") }
    }

    static var didSeeTipAlert: Bool {
        get { return UserDefaults.standard.bool(forKey: "didSeeAlert") }
        set { UserDefaults.standard.set(newValue, forKey: "didSeeAlert") }
    }

    static var didSeeCookInstructions: Bool {
        get { return UserDefaults.standard.bool(forKey: "cookinstructions") }
        set { UserDefaults.standard.set(newValue, forKey: "cookinstructions") }
    }

    static var currentCountryLocation: String {
        get { return UserDefaults.standard.string(forKey: "currentCountryLocation") ?? "ELSEWHERE" }
        set { UserDefaults.standard.set(newValue, forKey: "currentCountryLocation") }
    }
}


