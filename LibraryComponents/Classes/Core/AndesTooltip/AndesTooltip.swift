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

    @objc public var type: AndesTooltipType = .highlight {
        didSet {
            updateContentView()
        }
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public func show(in view: UIView, within superView: UIView) {
        self.contentView.show(in: view, within: superView)
    }

    @objc public init(type: AndesTooltipType) {
        super.init(frame: .zero)
        self.type = type
        setup()
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

    /// Check if view needs to be redrawn, and then update it. This method should be called on all modifiers that may need to change which internal view should be rendered
    private func reDrawContentViewIfNeededThenUpdate() {
        let newView = provideView()
        if Swift.type(of: newView) !== Swift.type(of: contentView) {
            contentView.removeFromSuperview()
            drawContentView(with: newView)
        }
        updateContentView()
    }

    private func updateContentView() {
        let config = AndesTooltipViewConfigFactory.provideInternalConfig(type: self.type)
        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesTooltipView {
        let config = AndesTooltipViewConfigFactory.provideInternalConfig(type: self.type)
        return AndesTooltipViewText(withConfig: config)
    }
}

// MARK: - IB interface
public extension AndesTooltip {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'type' instead.")
    @IBInspectable var ibType: String {
        set(val) {
            self.type = AndesTooltipType.checkValidEnum(property: "IB type", key: val)
        }
        get {
            return self.type.toString()
        }
    }
}
