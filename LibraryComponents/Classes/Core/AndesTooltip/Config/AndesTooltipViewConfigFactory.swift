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
    class func provideInternalConfig(tooltip: AndesTooltip) -> AndesTooltipViewConfig {
        let typeIns = AndesTooltipTypeFactory.provide(tooltip.type)

        let config = AndesTooltipViewConfig(
            type: typeIns,
            title: tooltip.title,
            content: tooltip.content,
            isDismissable: tooltip.isDismissable
        )

        return config
    }
}
