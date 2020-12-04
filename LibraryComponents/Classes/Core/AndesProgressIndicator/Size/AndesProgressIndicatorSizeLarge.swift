//
//  AndesProgressIndicatorSizeLarge.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//

import Foundation

internal struct AndesProgressIndicatorSizeLarge: AndesProgressIndicatorSizeProtocol {

    var strokeWidth: CGFloat = 4
    var height: CGFloat = 48
    var textSpacing: CGFloat = 20
    var textFont: UIFont = AndesStyleSheetManager.styleSheet.regularSystemFont(size: 16)

}
