//
//  AndesLinkButtonSizeMedium.swift
//  AndesUI
//
//  Created by Alexis Garcia on 13/07/2020.
//

import Foundation

internal struct AndesLinkButtonSizeMedium: AndesButtonSizeProtocol {

    public var font: UIFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14)

    public var height: CGFloat = 18

    public var borderRadius: CGFloat = 5

    public var padding: CGFloat = 0

    var spinnerSize: AndesProgressIndicatorSize = .medium

}
