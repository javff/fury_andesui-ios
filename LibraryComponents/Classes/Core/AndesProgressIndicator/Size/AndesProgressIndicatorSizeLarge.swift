//
//  AndesProgressIndicatorSizeLarge.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//

import Foundation

internal struct AndesProgressIndicatorSizeLarge: AndesProgressIndicatorSizeProtocol {

    public var font: UIFont = AndesStyleSheetManager.styleSheet.semiboldSystemFontOfSize(size: 12)

    public var height: CGFloat = 48

    public var borderRadius: CGFloat = 4

    public var padding: CGFloat = 8

}
