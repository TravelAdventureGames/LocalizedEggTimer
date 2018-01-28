//
//  Attributedstring+html.swift
//  Egg Timer
//
//  Created by Martijn van Gogh on 26-01-18.
//  Copyright © 2018 Martijn van Gogh. All rights reserved.
//

import Foundation

extension NSAttributedString {

    internal convenience init?(html: String, fontAttributes: [NSAttributedStringKey: Any]) {
        guard let data = html.data(using: String.Encoding.utf16, allowLossyConversion: false) else {
            return nil
        }

        guard
            let mutableAttributedString = try?  NSMutableAttributedString(data: data,
                                                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                                                    .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) else
        {
            return nil
        }

        mutableAttributedString.addAttributes(fontAttributes, range: NSRange(location: 0, length: mutableAttributedString.length))
        self.init(attributedString: mutableAttributedString)
    }
}

