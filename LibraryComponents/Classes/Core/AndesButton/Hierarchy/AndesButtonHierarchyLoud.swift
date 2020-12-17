//
//  AndesButtonLoud.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 17/12/2019.
//

import Foundation

/**
The AndesButtonSizeProtocol provides the differents attributes that define the style of the button, these can be constants or calculated
*/
internal struct AndesButtonHierarchyLoud: AndesButtonHierarchyProtocol {

    public var idleColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor

    public var pressedColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor700

    public var focusColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor

    public var disableColor: UIColor = UIColor.Andes.gray100

    public var fontColor: UIColor = AndesStyleSheetManager.styleSheet.textColorWhite

    var spinnerTintColor: UIColor = AndesStyleSheetManager.styleSheet.textColorWhite

}
