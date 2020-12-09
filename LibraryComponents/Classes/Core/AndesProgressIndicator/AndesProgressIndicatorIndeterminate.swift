//
//  
//  AndesProgressIndicator.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

@objc public class AndesProgressIndicatorIndeterminate: UIView {

    internal var contentView: AndesProgressIndicatorView!

    /// enum representing the size of the component.
    @objc public var size: AndesProgressIndicatorSize = .large {
        didSet {
            updateContentView()
        }
    }

    /// color of the component.
    @IBInspectable public var tint: UIColor? {
        didSet {
            updateContentView()
        }
    }

    /// text color of the component. This attribute is optional.
    @IBInspectable public var textColor: UIColor? {
        didSet {
            updateContentView()
        }
    }

    /// text content. This attribute is optional.
    @IBInspectable public var label: String? {
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

    /// is a component that gives feedback on an action with an indeterminate duration
    /// - Parameters:
    ///   - size: enum representing the size of the component.
    ///   - tint: color of the component.
    ///   - textColor: text color. This attribute is optional.
    ///   - label: text content. This attribute is optional.
    @objc public init(size: AndesProgressIndicatorSize,
                      tint: UIColor,
                      textColor: UIColor? = nil,
                      label: String? = nil) {
        super.init(frame: .zero)
        self.size = size
        self.textColor = textColor
        self.tint = tint
        self.label = label
        setup()
    }

    /// Starts the component animation. This animation indicates that a loading process has started.
    @objc public func startAnimation() {
        self.contentView.startAnimation(type: .infinity)
    }

    /// Stop the component animation. Remove all animations in this component.
    @objc public func stopAnimation() {
        self.contentView.stopAnimation()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        drawContentView(with: provideView())
    }

    private func drawContentView(with newView: AndesProgressIndicatorView) {
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
        let config = AndesProgressIndicatorViewConfigFactory.provideInternalConfig(
            textColor: self.textColor,
            tint: self.tint,
            label: self.label,
            size: self.size
        )
        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesProgressIndicatorView {
        let config = AndesProgressIndicatorViewConfigFactory.provideInternalConfig(
            textColor: self.textColor,
            tint: self.tint,
            label: self.label,
            size: self.size
        )
        return AndesProgressIndicatorViewCircular(withConfig: config)
    }
}

// MARK: - IB interface
public extension AndesProgressIndicatorIndeterminate {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'Size' instead.")
    @IBInspectable var ibSize: String {
        get {
            return self.size.toString()
        }
        set(val) {
            self.size = AndesProgressIndicatorSize.checkValidEnum(property: "IB size", key: val)
        }
    }
}
