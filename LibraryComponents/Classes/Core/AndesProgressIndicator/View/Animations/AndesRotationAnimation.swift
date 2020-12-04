//
//  AndesRotationAnimation.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 02-12-20.
//

import UIKit

class AndesRotationAnimation: CABasicAnimation {

    enum Direction: String {
        case axisX, axisY, axisZ
        
        func getAxisIdentifier() -> String {
            switch self {
            case .axisX:
                return "x"
            case .axisY:
                return "y"
            case .axisZ:
                return "z"
            }
        }
    }

    override init() {
        super.init()
    }

    public init(
        direction: Direction,
        fromValue: CGFloat,
        toValue: CGFloat,
        duration: Double,
        repeatCount: Float
    ) {

        super.init()
        self.keyPath = "transform.rotation.\(direction.getAxisIdentifier())"
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.repeatCount = repeatCount
        self.timingFunction = .init(name: .linear)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
