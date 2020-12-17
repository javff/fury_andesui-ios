//
//  AndesButtonQuiet.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 17/12/2019.
//

import Foundation

internal struct AndesButtonHierarchyQuiet: AndesButtonHierarchyProtocol {

    public var idleColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor150

    public var pressedColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor300

    public var focusColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor200

    public var disableColor: UIColor = UIColor.Andes.gray100

    public var fontColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor

    var spinnerTintColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor
}
