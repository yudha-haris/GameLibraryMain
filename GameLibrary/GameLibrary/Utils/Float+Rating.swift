//
//  Double+Rating.swift
//  GameLibrary
//
//  Created by Yudha Haris Purnama on 04/06/24.
//

import Foundation

extension Float {
    public func toRating() -> String {
        if self == 5 {
            return "⭐️⭐️⭐️⭐️⭐️"
        } else if self >= 4 {
            return "⭐️⭐️⭐️⭐️"
        } else if self >= 3 {
            return "⭐️⭐️⭐️"
        } else if self >= 2 {
            return "⭐️⭐️"
        } else if self >= 1 {
            return "⭐️"
        }
        
        return ""
    }
}
