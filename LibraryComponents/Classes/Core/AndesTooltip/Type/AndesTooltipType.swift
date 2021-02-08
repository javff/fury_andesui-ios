//
//  
//  AndesTooltipType.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

/// Used to define the colors of an AndesTooltip
@objc public enum AndesTooltipType: Int, AndesEnumStringConvertible {
    case light
    case dark
    case highlight

    public static func keyFor(_ value: AndesTooltipType) -> String {
        switch value {
        case .light: return "light"
        case .dark: return "dark"
        case .highlight: return "highlight"
        }
    }
}
