//
//  String+Extension.swift
//  LocalAccessbility
//
//  Created by Wonji Ha on 1/15/24.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
