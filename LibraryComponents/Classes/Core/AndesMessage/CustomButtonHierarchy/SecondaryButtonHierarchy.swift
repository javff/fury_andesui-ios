//
//  SecondaryButtonHierarchy.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 2/5/20.
//

import Foundation

struct SecondaryMessageActionButtonHierarchy: AndesButtonHierarchyProtocol {

    public var idleColor: UIColor = .clear

    public var pressedColor: UIColor

    public var focusColor: UIColor = .clear

    public var disableColor: UIColor = .clear

    public var fontColor: UIColor

    public var spinnerTintColor: UIColor = .clear

    init(textColor: UIColor, pressedColor: UIColor) {
        self.fontColor = textColor
        self.pressedColor = pressedColor
    }
}
