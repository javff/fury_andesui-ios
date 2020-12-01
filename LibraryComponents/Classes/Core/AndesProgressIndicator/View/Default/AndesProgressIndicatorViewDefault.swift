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

    @IBOutlet weak var containerView: AndesCircularProgressBar!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!

    private var progressLayer = CAShapeLayer()
    private var backgroundMask = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesProgressIndicatorViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
        guard let size = config.size else { return }
        self.containerViewHeightConstraint.constant = size.height
        self.containerView.backgroundColor = config.tint
    }

}
