//
//  String+Localization.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 30/05/24.
//

import Foundation

extension String {
    public func localized() -> String {
        let bundle = Bundle.main
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
