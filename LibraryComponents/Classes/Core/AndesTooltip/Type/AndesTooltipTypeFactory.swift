//
//  
//  AndesTooltipTypeFactory.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

class AndesTooltipTypeFactory {
    static func provide(_ type: AndesTooltipType) -> AndesTooltipTypeProtocol {
        return  AndesTooltipTypeSuccess()
//        switch type {
//        case .success:
//            return
//        case .error:
//            return AndesTooltipTypeError()
//        }
    }
}
