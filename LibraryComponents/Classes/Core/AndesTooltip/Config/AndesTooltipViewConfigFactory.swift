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

        let primaryActionConfig = createActionConfig(tooltipAction: tooltip.primaryAction, tooltipType: tooltip.type)

        let secondaryActionConfig = createActionConfig(tooltipAction: tooltip.secondaryAction, tooltipType: tooltip.type)

        let config = AndesTooltipViewConfig(
            type: typeIns,
            title: tooltip.title,
            content: tooltip.content,
            isDismissable: tooltip.isDismissable,
            primaryActionConfig: primaryActionConfig,
            secondaryActionConfig: secondaryActionConfig,
            primaryActionOnPressed: tooltip.primaryAction?.onPressed,
            secondaryActionOnPressed: tooltip.secondaryAction?.onPressed
        )

        return config
    }

    private class func createActionConfig(tooltipAction: AnesTooltipInternalAction?, tooltipType: AndesTooltipType) -> AndesButtonViewConfig? {
        guard let tooltipAction = tooltipAction else {
            return nil
        }
        return AndesTooltipActionFactory.provide(action: tooltipAction, tooltipType: tooltipType)
    }
}
