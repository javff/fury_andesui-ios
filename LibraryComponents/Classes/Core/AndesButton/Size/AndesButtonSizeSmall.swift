//
//  AndesButtonSmallSize.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 17/12/2019.
//

import Foundation

internal struct AndesButtonSizeSmall: AndesButtonSizeProtocol {

    public var font: UIFont = AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 12)

    public var height: CGFloat = 24

    public var borderRadius: CGFloat = 4

    public var padding: CGFloat = 8

    public var spinnerSize: AndesProgressIndicatorSize = .xSmall

}
