//
//  AndesSnackbarButtonSize.swift
//  AndesUI
//
//  Created by Samuel Sainz on 6/19/20.
//

import Foundation

internal struct AndesSnackbarButtonSize: AndesButtonSizeProtocol {
    public var font: UIFont = AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 14)

    public var height: CGFloat = 32

    public var borderRadius: CGFloat = 5

    public var padding: CGFloat = 8

    var spinnerSize: AndesProgressIndicatorSize = .medium
}
