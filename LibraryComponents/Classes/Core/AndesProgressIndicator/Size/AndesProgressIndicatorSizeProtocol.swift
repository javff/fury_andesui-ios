//
//  AndesProgressIndicatorSizeProtocol.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//

import Foundation

/**
 The AndesButtonSizeProtocol provides the differents attributes that define the size of the button, these can be constants or calculated
 */
internal protocol AndesProgressIndicatorSizeProtocol {

    var font: UIFont { get }
    var height: CGFloat { get }
    var padding: CGFloat { get }
}
