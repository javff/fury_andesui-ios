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
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var closeButtonHeightConstraint: NSLayoutConstraint!

    var config: AndesTooltipViewConfig

    lazy var tooltip: AndesBaseTooltipView = {
       let tooltip =  AndesBaseTooltipView(content: self, config: config)

        return tooltip
    }()
    init(withConfig config: AndesTooltipViewConfig) {
        self.config = config
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("")
    }

    internal func loadNib() {
        fatalError("This should be overriden by a subclass")
    }

    func update(withConfig config: AndesTooltipViewConfig) {
        self.config = config
        updateView()
    }

    @objc func show(in view: UIView, within superView: UIView) {
        tooltip.show(target: view, withinSuperview: superView)
    }

    @objc func dismiss() {
        self.tooltip.dismiss {
            // call completion dismiss
        }
    }

    func setup() {
        loadNib()
        translatesAutoresizingMaskIntoConstraints = false
        pinXibViewToSelf()
        updateView()
    }

    func updateView() {
        contentLabel.text = config.content
        contentLabel.setAndesStyle(style: config.contentStyle)
        renderTitleIfNeeded()
        renderCloseButtonIfNeeded()
    }

    private func renderTitleIfNeeded() {
        guard let title = config.title else {
            titleLabel.removeFromSuperview()
            return
        }

        titleLabel.text = title
        titleLabel.setAndesStyle(style: config.titleStyle)
    }

    private func renderCloseButtonIfNeeded() {
        if !config.isDismissable {
            hideCloseButton()
            return

        }
        let closeIcon = AndesIcons.close16
        AndesIconsProvider.loadIcon(name: closeIcon) { image in
            self.closeButton.setImage(image, for: .normal)
            self.closeButton.tintColor = config.closeButtonColor
        }
    }

    private func hideCloseButton() {
        self.closeButtonHeightConstraint.constant = 0
    }

    func pinXibViewToSelf() {
        addSubview(componentView)
        componentView.translatesAutoresizingMaskIntoConstraints = false
        componentView.pinToSuperview()
    }

    @IBAction func closeButtonTapped() {
        self.dismiss()
    }
}
