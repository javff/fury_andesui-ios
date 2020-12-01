//
//  
//  AndesProgressIndicatorViewDefault.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import UIKit

class AndesProgressIndicatorViewDefault: AndesProgressIndicatorAbstractView {

    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesProgressIndicatorViewDefault", owner: self, options: nil)
        setupLayers()
    }

    override func updateView() {
        super.updateView()
        self.draw(in: componentView.frame)
    }

    private func setupLayers() {
        guard let size = config.size else { return }

        backgroundMask.lineWidth = size.height
        backgroundMask.fillColor = nil
        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask

        progressLayer.lineWidth = size.height
        progressLayer.fillColor = nil
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }

    private func draw(in rect: CGRect) {
        guard let size = config.size else { return }

        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: size.height / 2, dy: size.height / 2))
        backgroundMask.path = circlePath.cgPath

        progressLayer.path = circlePath.cgPath
        progressLayer.lineCap = .round
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0.3
        progressLayer.strokeColor = config.tint?.cgColor
    }
}
