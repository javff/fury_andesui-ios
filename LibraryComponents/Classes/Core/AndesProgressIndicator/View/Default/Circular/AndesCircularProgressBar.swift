//
//  AndesCircularProgressBar.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 01-12-20.
//

import UIKit

@IBDesignable
internal class AndesCircularProgressBar: UIView {

    @IBInspectable var color: UIColor? = .gray {
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

    private func setupLayers() {
        backgroundMask.lineWidth = ringWidth
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask

        progressLayer.lineWidth = ringWidth
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }

    override func draw(_ rect: CGRect) {
        setupLayers()

        let insideRect = rect.insetBy(
            dx: ringWidth,
            dy: ringWidth
        )
        let circlePath = UIBezierPath(ovalIn: insideRect)
        backgroundMask.path = circlePath.cgPath

        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = progress
        progressLayer.strokeColor = color?.cgColor
    }
}
