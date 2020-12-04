//
//  
//  AndesProgressIndicatorAbstractView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import UIKit

class AndesProgressIndicatorAbstractView: UIView, AndesProgressIndicatorView {

    @IBOutlet weak var componentView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var circularProgressBar: AndesCircularProgressBar!

    var config: AndesProgressIndicatorViewConfig
    init(withConfig config: AndesProgressIndicatorViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesProgressIndicatorViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesProgressIndicatorViewConfig) {
        self.config = config
        updateView()
    }

    func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.pinToSuperview()
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    /// Override this method on each ProgressIndicator View to setup its unique components
    func updateView() {
        guard let size = config.size else { return }
        self.containerViewHeightConstraint.constant = size.height
        self.circularProgressBar.ringWidth = size.strokeWidth
        self.circularProgressBar.color = config.tint
        self.textLabel.text = config.label
        self.textLabel.textColor = config.textColor
        self.textLabel.font = size.textFont
        let labelIsAvailable = config.label != nil
        self.stackView.spacing = labelIsAvailable ? size.textSpacing : 0
    }

    func startAnimation(type: AndesCircularProgressBar.AnimationType) {
        self.circularProgressBar.startAnimation(type)
    }

    func stopAnimation() {
        self.circularProgressBar.stopAnimation()
    }
}
