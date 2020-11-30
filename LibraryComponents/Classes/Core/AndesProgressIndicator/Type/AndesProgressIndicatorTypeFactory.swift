//
//  
//  AndesProgressIndicatorTypeFactory.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

class AndesProgressIndicatorTypeFactory {
    static func provide(_ type: AndesProgressIndicatorType) -> AndesProgressIndicatorTypeProtocol {
        switch type {
        case .linear:
            fatalError()
//            return AndesProgressIndicatorTypeSuccess()
        case .circular:
            fatalError()
//            return AndesProgressIndicatorTypeError()
        }
    }
}
