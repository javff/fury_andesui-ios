//
//  
//  AndesTooltipTypeFactory.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

class AndesTooltipTypeFactory {
    static func provide(_ type: AndesTooltipType) -> AndesTooltipTypeProtocol {
        switch type {
        case .light:
            return AndesTooltipTypeLight()
        case .dark:
            return AndesTooltipTypeDark()
        case .highlight:
            return AndesTooltipTypeHighlight()
        }
    }
}
