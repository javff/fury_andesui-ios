//
//  TooltipActionDarkUseCase.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 11-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

class TooltipActionDarkUseCase: TooltipActionUseCaseDataSource {

    func titleForType() -> String {
        return "Primary Action"
    }

    func supportTypes() -> [TooltipActionType] {
        return [.loud, .link]
    }

}

class TooltipDarkSecondaryCase: TooltipActionUseCaseDataSource {

    let primaryAction: TooltipActionType

    init(primaryAction: TooltipActionType) {
        self.primaryAction = primaryAction
    }

    func titleForType() -> String {
        return "Secondary Action"
    }

    func supportTypes() -> [TooltipActionType] {
        switch primaryAction {
        case .loud:
            return [.transparent]
        case .link:
            return []
        case .quiet:
            return []
        case .transparent:
            return []
        }
    }
}

class TooltipDarkFactory: TooltipAbstractFactory {

    func buildTooltip(using showCase: TooltipDataShowCase) -> AndesTooltip? {
        guard showCase.primaryActionStyle != nil,
               showCase.primayActionText != nil else {
            return buildWithoutAction(using: showCase)
        }

        guard showCase.secondaryActionStyle != nil,
             showCase.secondaryActionText != nil else {
            return buildWithPrimaryActionOnly(using: showCase)
        }

        return buildWithPrimaryAndSecondaryAction(using: showCase)

    }

    func buildWithoutAction(using showCase: TooltipDataShowCase) -> AndesTooltip {
        return AndesTooltip(darkStyle: showCase.content, title: showCase.title, isDismissable: showCase.isDissmisable)
    }

    func buildWithPrimaryActionOnly(using showCase: TooltipDataShowCase) -> AndesTooltip? {
        guard let primaryActionStyle = showCase.primaryActionStyle,
              let primaryActionText = showCase.primayActionText else { return nil }

        if primaryActionStyle == .link {
            return AndesTooltip(darkStyle: showCase.content,
                         title: showCase.title,
                         isDismissable: showCase.isDissmisable,
                         linkAction: AndesTooltipAction(text: primaryActionText, onPressed: {

                         }))
        }

        if primaryActionStyle == .loud {
            return AndesTooltip(darkStyle: showCase.content,
                         title: showCase.title,
                         isDismissable: showCase.isDissmisable,
                         primaryLoudAction: AndesTooltipAction(text: primaryActionText, onPressed: {

                         }))
        }

        return nil
    }

    func buildWithPrimaryAndSecondaryAction(using showCase: TooltipDataShowCase) -> AndesTooltip? {
        guard let primaryActionStyle = showCase.primaryActionStyle,
              let primaryActionText = showCase.primayActionText,
              let secondaryActionStyle = showCase.secondaryActionStyle,
              let secondaryActionText = showCase.secondaryActionText else { return nil }

        if primaryActionStyle == .loud && secondaryActionStyle == .transparent {
            return AndesTooltip(darkStyle: showCase.content,
                                title: showCase.title,
                                isDismissable: showCase.isDissmisable,
                                primaryLoudAction: AndesTooltipAction(text: primaryActionText, onPressed: {

                                }),
                                secondaryTransparentAction: AndesTooltipAction(text: secondaryActionText, onPressed: {

                                }))
        }

        return nil
    }
}
