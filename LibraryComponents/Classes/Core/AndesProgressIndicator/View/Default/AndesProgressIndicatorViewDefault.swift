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

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!

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
        self.draw()
    }

    private func setupLayers() {

//        backgroundMask.lineWidth = 4
//        backgroundMask.fillColor = nil
//        backgroundMask.strokeColor = UIColor.black.cgColor
//        layer.mask = backgroundMask
//
//        progressLayer.lineWidth = 4
//        progressLayer.fillColor = UIColor.gray.cgColor
//        layer.addSublayer(progressLayer)
//        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, -1)
    }

    private func draw() {
        guard let size = config.size else { return }
        self.containerViewHeightConstraint.constant = size.height
//        self.layoutIfNeeded()
//        let circlePath = UIBezierPath(ovalIn: rect.insetBy(dx: size.height / 2, dy: size.height / 2))
//        backgroundMask.path = circlePath.cgPath
//
//        progressLayer.path = circlePath.cgPath
//        progressLayer.lineCap = .round
//        progressLayer.strokeStart = 0
//        progressLayer.strokeEnd = 0.5
//        progressLayer.strokeColor = config.tint?.cgColor
    }
}
