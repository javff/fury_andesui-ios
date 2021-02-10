//
//  AndesTooltipActionLinkHierarchy.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 10-02-21.
//

import Foundation

struct AndesTooltipActionLinkHierarchy: AndesButtonHierarchyProtocol {

    var idleColor: UIColor = .clear
    var pressedColor: UIColor
    var focusColor: UIColor = .clear
    var disableColor: UIColor = .clear
    var fontColor: UIColor
    var spinnerTintColor: UIColor = .clear

    init(textColor: UIColor, pressedColor: UIColor) {
        self.fontColor = textColor
        self.pressedColor = pressedColor
    }
}
