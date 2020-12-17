//
//  PrimaryButtonHierarchy.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 1/31/20.
//

import Foundation

struct PrimaryMessageActionButtonHierarchy: AndesButtonHierarchyProtocol {
    var idleColor: UIColor

    var pressedColor: UIColor

    var disableColor: UIColor  = UIColor.Andes.gray100

    var fontColor: UIColor = AndesStyleSheetManager.styleSheet.textColorWhite

    var spinnerTintColor: UIColor = .clear

    init(backgroundColor: UIColor, pressedColor: UIColor) {
        self.idleColor = backgroundColor
        self.pressedColor = pressedColor
    }
}
