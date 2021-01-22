//
//  
//  AndesTooltipAbstractView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import UIKit

class AndesTooltipAbstractView: UIView, AndesTooltipView {
    @IBOutlet weak var componentView: UIView!

    var config: AndesTooltipViewConfig

    lazy var tooltip: AndesBaseTooltipView = {
        let background = config.backgroundColor
        let tooltip = AndesBaseTooltipView(content: componentView, config: AndesBaseTooltipExternalConfig(backgroundColor: .blue, foregroundColor: .red))
       return tooltip
    }()

    init(withConfig config: AndesTooltipViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        config = AndesTooltipViewConfig()
        super.init(coder: coder)
        setup()
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesTooltipViewConfig) {
        self.config = config
        updateView()
    }

    @objc func show(in view: UIView, within superView: UIView) {
        tooltip.show(forView: view, withinSuperview: superView)
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

    /// Override this method on each Badge View to setup its unique components
    func updateView() {
        self.backgroundColor = config.backgroundColor
    }

}
