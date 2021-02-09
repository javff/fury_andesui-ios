//
//  
//  AndesTooltipTypeProtocol.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

internal protocol AndesTooltipTypeProtocol {
    var textColor: UIColor { get }
    var closeButtonColor: UIColor { get }
    var backgroundColor: UIColor { get }
    var maxWidth: CGFloat { get }
    var shadowOffset: CGSize { get }
    var shadowRadius: CGFloat { get }
    var shadowOpacity: CGFloat { get }
}
