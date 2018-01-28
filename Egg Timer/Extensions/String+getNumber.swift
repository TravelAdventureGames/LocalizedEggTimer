//
//  String+getNumber.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 24-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation

extension String {
    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .flatMap { pattern ~= $0 ? Character($0) : nil })
    }
}
