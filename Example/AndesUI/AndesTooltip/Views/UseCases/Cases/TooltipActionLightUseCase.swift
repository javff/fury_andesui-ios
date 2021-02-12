//
//  TooltipActionLightUseCase.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 10-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

protocol TooltipAbstractFactory: class {
    func buildTooltip(using showCase: TooltipDataShowCase) -> AndesTooltip?
}

class TooltipLightPrimaryCases: TooltipActionUseCaseDataSource {

    func titleForType() -> String {
        return "Primary Action"
    }

    func supportTypes() -> [TooltipActionType] {
        return [.loud, .quiet, .link]
    }

}

class TooltipLightSecondaryCases: TooltipActionUseCaseDataSource {

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
            return [.quiet]
        case .transparent:
            return []
        }
    }
}

class TooltipLightFactory: TooltipAbstractFactory {

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
        return AndesTooltip(lightStyle: showCase.content, title: showCase.title, isDismissable: showCase.isDissmisable)
    }

    func buildWithPrimaryActionOnly(using showCase: TooltipDataShowCase) -> AndesTooltip? {
        guard let primaryActionStyle = showCase.primaryActionStyle,
              let primaryActionText = showCase.primayActionText else { return nil }

        if primaryActionStyle == .link {
            return AndesTooltip(lightStyle: showCase.content,
                         title: showCase.title,
                         isDismissable: showCase.isDissmisable,
                         linkAction: AndesTooltipAction(text: primaryActionText, onPressed: {

                         }))
        }

        if primaryActionStyle == .loud {
            return AndesTooltip(lightStyle: showCase.content,
                         title: showCase.title,
                         isDismissable: showCase.isDissmisable,
                         primaryLoudAction: AndesTooltipAction(text: primaryActionText, onPressed: {

                         }))
        }

        if primaryActionStyle == .quiet {
            return AndesTooltip(lightStyle: showCase.content,
                         title: showCase.title,
                         isDismissable: showCase.isDissmisable,
                         primaryQuietAction: AndesTooltipAction(text: primaryActionText, onPressed: {

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
            return AndesTooltip(lightStyle: showCase.content,
                                title: showCase.title,
                                isDismissable: showCase.isDissmisable,
                                primaryLoudAction: AndesTooltipAction(text: primaryActionText, onPressed: {

                                }),
                                secondaryTransparentAction: AndesTooltipAction(text: secondaryActionText, onPressed: {

                                }))
        }

        if primaryActionStyle == .quiet && secondaryActionStyle == .quiet {
            return AndesTooltip(lightStyle: showCase.content,
                                title: showCase.title,
                                isDismissable: showCase.isDissmisable,
                                primaryQuietAction: AndesTooltipAction(text: primaryActionText, onPressed: {

                                }),
                                secondaryQuietAction: AndesTooltipAction(text: secondaryActionText, onPressed: {

                                }))
        }

        return nil
    }
}
