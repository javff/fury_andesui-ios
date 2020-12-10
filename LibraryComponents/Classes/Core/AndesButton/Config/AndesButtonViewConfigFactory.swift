//
//  AndesButtonViewConfigFactory.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 22/01/2020.
//

import Foundation

/**
The responsability of the factory is to provide the ViewConfig from the user specified attributes
*/
internal class AndesButtonViewConfigFactory {

    static func provide(hierarchy: AndesButtonHierarchy, size: AndesButtonSize, text: String, textattributes: [NSAttributedString.Key: Any] = [:], icon: AndesButtonIcon?) -> AndesButtonViewConfig {

        let buttonHierarchy = AndesButtonHierarchyFactory.provideStyle(key: hierarchy)
        let buttonSize = AndesButtonSizeFactory.provideStyle(key: size, icon: icon)
        return provide(hierarchy: buttonHierarchy,
                       size: buttonSize,
                       text: text,
                       textattributes: textattributes,
                       icon: icon)
    }

    static func provide(hierarchy: AndesButtonHierarchyProtocol, size: AndesButtonSizeProtocol, text: String, textattributes: [NSAttributedString.Key: Any] = [:], icon: AndesButtonIcon?) -> AndesButtonViewConfig {

        let viewConfig = AndesButtonViewConfig(backgroundColor: hierarchy.idleColor.cgColor,
                                               pressedColor: hierarchy.pressedColor.cgColor,
                                               disableColor: hierarchy.disableColor.cgColor,
                                               text: text, textColor: hierarchy.fontColor,
                                               textAttributes: textattributes,
                                               textDisableColor: AndesStyleSheetManager.styleSheet.textColorDisabled,
                                               font: size.font,
                                               cornerRadius: size.borderRadius,
                                               height: size.height,
                                               padding: size.padding,
                                               icon: icon?.icon,
                                               iconColor: hierarchy.fontColor,
                                               iconDisableColor: AndesStyleSheetManager.styleSheet.textColorDisabled,
                                               spinnerTintColor: hierarchy.spinnerTintColor,
                                               spinnerSize: size.spinnerSize)

        return viewConfig
    }
}
