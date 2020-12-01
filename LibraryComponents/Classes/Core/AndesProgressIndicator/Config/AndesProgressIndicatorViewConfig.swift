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

    init(
        textColor: UIColor?,
        tint: UIColor?,
        label: String?,
        size: AndesProgressIndicatorSizeProtocol?) {
        self.textColor = textColor
        self.tint = tint
        self.label = label
        self.size = size
    }
}
