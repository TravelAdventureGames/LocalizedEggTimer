//
//  String+localized.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 28-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}


