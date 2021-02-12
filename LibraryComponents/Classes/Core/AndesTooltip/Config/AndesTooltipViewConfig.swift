//
//  
//  AndesTooltipViewConfig.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

/// used to define the ui of internal AndesTooltip views
internal struct AndesTooltipViewConfig {

    let title: String?
    let content: String
    let isDismissable: Bool

    let textColor: UIColor
    let backgroundColor: UIColor
    let closeButtonColor: UIColor
    let maxWidth: CGFloat
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
    let shadowOpacity: CGFloat

    var primaryActionConfig: AndesButtonViewConfig?
    var secondaryActionConfig: AndesButtonViewConfig?

    var primaryActionOnPressed: (() -> Void)?
    var secondaryActionOnPressed: (() -> Void)?

    lazy var titleStyle: AndesFontStyle = {
        return AndesFontStyle(
            textColor: self.textColor,
            font: AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 16),
            sketchLineHeight: 20
        )
    }()

    lazy var contentStyle: AndesFontStyle = {
        return AndesFontStyle(
            textColor: self.textColor,
            font: AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14),
            sketchLineHeight: 18
        )
    }()

    init(type: AndesTooltipTypeProtocol,
         title: String?,
         content: String,
         isDismissable: Bool,
         primaryActionConfig: AndesButtonViewConfig?,
         secondaryActionConfig: AndesButtonViewConfig?,
         primaryActionOnPressed: (() -> Void)?,
         secondaryActionOnPressed: (() -> Void)?) {
        backgroundColor = type.backgroundColor
        maxWidth = type.maxWidth
        shadowOffset = type.shadowOffset
        shadowRadius = type.shadowRadius
        shadowOpacity = type.shadowOpacity
        textColor = type.textColor
        closeButtonColor = type.closeButtonColor

        self.title = title
        self.content = content
        self.isDismissable = isDismissable
        self.primaryActionConfig = primaryActionConfig
        self.secondaryActionConfig = secondaryActionConfig
        self.primaryActionOnPressed = primaryActionOnPressed
        self.secondaryActionOnPressed = secondaryActionOnPressed
    }
}
