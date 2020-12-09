//
//  AndesCircularProgressBar.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 01-12-20.
//

import UIKit

@IBDesignable
internal class AndesCircularProgressBar: UIView {

    enum AnimationType {
        case infinity
        case madeProgress(progress: CGFloat)
    }

    @IBInspectable var color: UIColor? {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var ringWidth: CGFloat = 10 {
        didSet { setNeedsDisplay() }
    }

    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()

    private let rotationAnimationDuration: Double = 2
    private let strokeAnimationDuration: Double = 1.5

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayers()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupLayers()
    }

    private func setupLayers() {
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.gray.cgColor
        layer.mask = backgroundMask

        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }

    override func draw(_ rect: CGRect) {
        let insideRect = rect.insetBy(
            dx: ringWidth / 2,
            dy: ringWidth / 2
        )
        let circlePath = UIBezierPath(ovalIn: insideRect)
        backgroundMask.path = circlePath.cgPath
        backgroundMask.lineWidth = ringWidth
        backgroundMask.lineCap = .round

        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = color?.cgColor
        progressLayer.lineWidth = ringWidth
    }

    func startAnimation(_ type: AnimationType) {
        switch type {
        case .infinity:
            self.startInfiniteAnimation()
        case .madeProgress:
            break
        }
    }

    private func startInfiniteAnimation() {
        self.animateRotation()
        self.animateStroke()
    }

    func stopAnimation() {
        self.layer.removeAllAnimations()
        self.progressLayer.removeAllAnimations()
        self.backgroundMask.removeAllAnimations()
    }

    private func animateStroke() {

        let strokeAnimationMidDuration = strokeAnimationDuration / 2

        let beginAnimation = AndesStrokeAnimation(
            type: .end,
            fromValue: 0.0,
            toValue: 0.75,
            duration: strokeAnimationMidDuration
        )

        let midAnimation = AndesStrokeAnimation(
            type: .start,
            beginTime: 0.75,
            fromValue: 0.0,
            toValue: 0.97,
            duration: strokeAnimationMidDuration
        )

        let endAnimation = AndesStrokeAnimation(
            type: .end,
            beginTime: 0.75,
            fromValue: 0.75,
            toValue: 1,
            duration: strokeAnimationMidDuration
        )

        let strokeAnimationGroup = CAAnimationGroup()
        strokeAnimationGroup.duration = strokeAnimationDuration
        strokeAnimationGroup.repeatDuration = .infinity
        strokeAnimationGroup.animations = [
            beginAnimation,
            midAnimation,
            endAnimation
        ]

        backgroundMask.add(strokeAnimationGroup, forKey: "startAnimation")
    }

    private func animateRotation() {
        let rotationAnimation = AndesRotationAnimation(
            direction: .axisZ,
            fromValue: 0,
            toValue: CGFloat.pi * 2,
            duration: rotationAnimationDuration,
            repeatCount: .infinity
        )

        self.layer.add(rotationAnimation, forKey: "rotateAnimation")
    }
}
