//
//  AndesProgressIndicatorSizeMedium.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//

import Foundation

internal struct AndesProgressIndicatorSizeMedium: AndesProgressIndicatorSizeProtocol {
    var textSpacing: CGFloat = 16
    var strokeWidth: CGFloat = 3
    var height: CGFloat = 32

    var textFont: UIFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14)

}
