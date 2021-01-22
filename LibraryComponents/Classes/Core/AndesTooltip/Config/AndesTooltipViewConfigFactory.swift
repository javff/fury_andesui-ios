//
//  
//  AndesTooltipViewConfigFactory.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

internal class AndesTooltipViewConfigFactory {
    static func provideInternalConfig(type: AndesTooltipType) -> AndesTooltipViewConfig {
        let typeIns = AndesTooltipTypeFactory.provide(type)

        let config = AndesTooltipViewConfig(type: typeIns)

        return config
    }
}
