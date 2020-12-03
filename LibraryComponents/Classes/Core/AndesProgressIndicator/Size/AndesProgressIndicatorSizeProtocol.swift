//
//  AndesProgressIndicatorSizeProtocol.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//

import Foundation

/**
 The AndesProgressIndicatorSizeProtocol provides the differents attributes that define the size of the Indicator, these can be constants or calculated
 */
internal protocol AndesProgressIndicatorSizeProtocol {
    var strokeWidth: CGFloat { get }
    var height: CGFloat { get }
    var textSpacing: CGFloat { get }

    var textFont: UIFont { get }
}
