//
//  AndesProgressIndicatorSizeSmall.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//

import Foundation

internal struct AndesProgressIndicatorSizeSmall: AndesProgressIndicatorSizeProtocol {
    var textSpacing: CGFloat = 16
    var strokeWidth: CGFloat = 2.5
    var height: CGFloat = 24

    var textFont: UIFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 14)

}
