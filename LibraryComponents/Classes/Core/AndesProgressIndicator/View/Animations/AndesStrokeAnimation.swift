//
//  AndesStrokeAnimation.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 01-12-20.
//

import Foundation

internal class AndesStrokeAnimation: CABasicAnimation {

    enum AnimationType {
        case start
        case end
    }

    override init() {
        super.init()
    }

    init(type: AnimationType,
         beginTime: Double = 0.0,
         fromValue: CGFloat,
         toValue: CGFloat,
         duration: Double) {

        super.init()

        self.keyPath = type == .start ? "strokeStart" : "strokeEnd"

        self.beginTime = beginTime
        self.fromValue = fromValue
        self.toValue = toValue
        self.duration = duration
        self.timingFunction = .init(name: .easeInEaseOut)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
