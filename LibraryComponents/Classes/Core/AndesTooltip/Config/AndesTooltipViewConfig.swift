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
    let backgroundColor: UIColor
    let maxWidth: CGFloat
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
    let shadowOpacity: CGFloat

    init(type: AndesTooltipTypeProtocol) {
        self.backgroundColor = .white
        self.maxWidth = 240
        shadowOffset = CGSize(width: 0, height: 0)
        shadowRadius = CGFloat(6)
        shadowOpacity = CGFloat(0.4)
    }
}
