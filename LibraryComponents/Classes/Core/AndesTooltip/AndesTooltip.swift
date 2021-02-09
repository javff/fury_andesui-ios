//
//  
//  AndesTooltip.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

@objc public class AndesTooltip: UIView {
    internal var contentView: AndesTooltipView!
    var type: AndesTooltipType = .light

    let title: String?
    let content: String
    let isDismissable: Bool

    public func show(in view: UIView, within superView: UIView) {
        self.contentView.show(in: view, within: superView)
    }

    public init(title: String?, content: String, isDismissable: Bool = true) {
        self.content = content
        self.title = title
        self.isDismissable = isDismissable
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func drawContentView(with newView: AndesTooltipView) {
        self.contentView = newView
        addSubview(contentView)
        contentView.pinToSuperview()
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesTooltipView {
        let config = AndesTooltipViewConfigFactory.provideInternalConfig(tooltip: self)
        return AndesTooltipViewText(withConfig: config)
    }
}
