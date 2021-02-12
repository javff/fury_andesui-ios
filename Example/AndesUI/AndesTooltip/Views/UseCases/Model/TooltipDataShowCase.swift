//
//  TooltipDataShowCase.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 11-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

struct TooltipDataShowCase {
    var content: String
    var title: String?
    var isDissmisable: Bool
    var tooltipType: AndesTooltipType?

    var primaryActionStyle: TooltipActionType?
    var primayActionText: String?
    var secondaryActionStyle: TooltipActionType?
    var secondaryActionText: String?

    func isValid() -> Bool {
        if content.isEmpty { return false }

        if hasSecondaryAction() {
            return primaryActionIsValid() && secondaryActionIsValid()
        }

        if hasPrimaryAction() {
            return primaryActionIsValid()
        }

        return true
    }

    func primaryActionIsValid() -> Bool {
        guard let primaryActionText = primayActionText,
              primaryActionStyle != nil else {
            return false
        }
        return !primaryActionText.isEmpty
    }

    func secondaryActionIsValid() -> Bool {
        guard let secondaryActionText = secondaryActionText,
              secondaryActionStyle != nil else {
            return false
        }
        return !secondaryActionText.isEmpty
    }

    func hasPrimaryAction() -> Bool {
        return primayActionText != nil || primaryActionStyle != nil
    }

    func hasSecondaryAction() -> Bool {
        return secondaryActionText != nil || secondaryActionStyle != nil
    }
}
