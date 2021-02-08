//
//  
//  AndesTooltipViewConfig.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

/// used to define the ui of internal AndesTooltip views
internal struct AndesTooltipViewConfig {
    var textColor: UIColor
    let backgroundColor: UIColor
    let maxWidth: CGFloat
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
    let shadowOpacity: CGFloat

    init(type: AndesTooltipTypeProtocol) {
        backgroundColor = type.backgroundColor
        maxWidth = type.maxWidth
        shadowOffset = type.shadowOffset
        shadowRadius = type.shadowRadius
        shadowOpacity = type.shadowOpacity
        textColor = type.textColor
    }
}
