//
//  AndesButtonTransparent.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 17/12/2019.
//

import Foundation

internal struct AndesButtonHierarchyTransparent: AndesButtonHierarchyProtocol {

    public var idleColor: UIColor = .clear

    public var pressedColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor200

    public var focusColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor100

    public var disableColor: UIColor = .clear

    public var fontColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor

    var spinnerTintColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor
}
