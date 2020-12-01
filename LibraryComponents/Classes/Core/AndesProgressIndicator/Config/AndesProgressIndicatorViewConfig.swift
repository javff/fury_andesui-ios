//
//  
//  AndesProgressIndicatorViewConfig.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

/// used to define the ui of internal AndesProgressIndicator views
internal struct AndesProgressIndicatorViewConfig {

    var tint: UIColor?
    var textColor: UIColor?
    var label: String?
    var size: AndesProgressIndicatorSizeProtocol?

    init () {}

    init(type: AndesProgressIndicatorTypeProtocol) {
        self.textColor = type.textColor
        self.tint = type.tint
        self.label = type.label
        self.size = type.size
    }
}
