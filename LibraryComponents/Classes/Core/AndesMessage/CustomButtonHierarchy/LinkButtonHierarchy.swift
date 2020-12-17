//
//  LinkButtonHierarchy.swift
//  AndesUI
//
//  Created by Alexis Garcia on 29/06/2020.
//

import Foundation

struct LinkMessageActionButtonHierarchy: AndesButtonHierarchyProtocol {

    public var idleColor: UIColor = .clear

    public var pressedColor: UIColor

    public var focusColor: UIColor = .clear

    public var disableColor: UIColor = .clear

    public var fontColor: UIColor

    var spinnerTintColor: UIColor = .clear

    init(textColor: UIColor, pressedColor: UIColor) {
        self.fontColor = textColor
        self.pressedColor = pressedColor
    }
}
