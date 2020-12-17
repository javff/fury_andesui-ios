//
//  AndesButtonLargeSize.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 17/12/2019.
//

import Foundation

internal struct AndesButtonSizeLarge: AndesButtonSizeProtocol {

    public init(buttonIcon: AndesButtonIcon? = nil) {
        self.padding = buttonIcon == nil ? 24 : 16
    }

    public var font: UIFont = AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 16)

    public var height: CGFloat = 48

    public var borderRadius: CGFloat = 6

    public var padding: CGFloat

    public var spinnerSize: AndesProgressIndicatorSize = .small

}
