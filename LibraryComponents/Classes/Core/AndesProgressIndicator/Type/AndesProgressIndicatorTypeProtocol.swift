//
//  
//  AndesProgressIndicatorTypeProtocol.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

internal protocol AndesProgressIndicatorTypeProtocol {
    var tint: UIColor { get }
    var textColor: UIColor? { get }
    var label: String? { get }
}
