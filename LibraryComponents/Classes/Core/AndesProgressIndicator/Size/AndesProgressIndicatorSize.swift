//
//  AndesProgressIndicatorSize.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//

import Foundation

/**
 The AndesProgressIndicatorSize contains the different sizes that a button supports
 */
@objc public enum AndesProgressIndicatorSize: Int, AndesEnumStringConvertible {
    case large
    case medium
    case small

    public static func keyFor(_ value: AndesProgressIndicatorSize) -> String {
        switch value {
        case .large: return "LARGE"
        case .medium: return "MEDIUM"
        case .small: return "SMALL"
        }
    }
}
