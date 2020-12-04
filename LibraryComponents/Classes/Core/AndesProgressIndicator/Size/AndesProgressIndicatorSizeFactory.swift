//
//  AndesProgressIndicatorSizeFactory.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//

import Foundation

/**
 The responsability of the factory is to provide the right size by providing the AndesProgressIndicatorSize
 */
class AndesProgressIndicatorSizeFactory {
    static func provideStyle(key: AndesProgressIndicatorSize) -> AndesProgressIndicatorSizeProtocol {
        switch key {
        case .large:
            return AndesProgressIndicatorSizeLarge()
        case .medium:
            return AndesProgressIndicatorSizeMedium()
        case .small:
            return AndesProgressIndicatorSizeSmall()
        }
    }
}
