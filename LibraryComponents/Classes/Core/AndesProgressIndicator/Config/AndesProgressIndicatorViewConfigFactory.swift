//
//  
//  AndesProgressIndicatorViewConfigFactory.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

internal class AndesProgressIndicatorViewConfigFactory {
    static func provideInternalConfig(type: AndesProgressIndicatorType) -> AndesProgressIndicatorViewConfig {
        let typeIns = AndesProgressIndicatorTypeFactory.provide(type)

        let config = AndesProgressIndicatorViewConfig(type: typeIns)

        return config
    }
}
