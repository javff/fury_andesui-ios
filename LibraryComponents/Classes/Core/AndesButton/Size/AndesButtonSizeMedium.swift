//
//  AndesButtonMediumSize.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 17/12/2019.
//

import Foundation

internal struct AndesButtonSizeMedium: AndesButtonSizeProtocol {

    public var font: UIFont = AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 14)

    public var height: CGFloat = 32

    public var borderRadius: CGFloat = 5

    public var padding: CGFloat = 12

    var spinnerSize: AndesProgressIndicatorSize = .xSmall

}
