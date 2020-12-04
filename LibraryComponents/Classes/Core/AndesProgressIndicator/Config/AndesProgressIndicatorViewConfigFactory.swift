//
//  
//  AndesProgressIndicatorViewConfigFactory.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

internal class AndesProgressIndicatorViewConfigFactory {
    static func provideInternalConfig(
        textColor: UIColor?,
        tint: UIColor?,
        label: String?,
        size: AndesProgressIndicatorSize) -> AndesProgressIndicatorViewConfig {

        let size = AndesProgressIndicatorSizeFactory.provideStyle(key: size)

        let config = AndesProgressIndicatorViewConfig(
            textColor: textColor,
            tint: tint,
            label: label,
            size: size
        )

        return config
    }
}
