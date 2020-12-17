//
//  AndesButtonSize.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 17/12/2019.
//

import Foundation

/**
 The AndesButtonSizeProtocol provides the differents attributes that define the size of the button, these can be constants or calculated
 */
internal protocol AndesButtonSizeProtocol {

    var font: UIFont { get }
    var height: CGFloat { get }
    var borderRadius: CGFloat { get }
    var padding: CGFloat { get }

    var spinnerSize: AndesProgressIndicatorSize { get }
}
