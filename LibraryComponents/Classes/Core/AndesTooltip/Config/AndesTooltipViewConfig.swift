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

    init(type: AndesTooltipTypeProtocol) {
        self.backgroundColor = .white
    }
}
