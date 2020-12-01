//
//  
//  AndesProgressIndicatorType.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

/// Used to define the colors of an AndesProgressIndicator
@objc public enum AndesProgressIndicatorType: Int, AndesEnumStringConvertible {
    case circular
    case linear

    public static func keyFor(_ value: AndesProgressIndicatorType) -> String {
        switch value {
        case .linear: return "LINEAR"
        case .circular: return "CIRCULAR"
        }
    }
}