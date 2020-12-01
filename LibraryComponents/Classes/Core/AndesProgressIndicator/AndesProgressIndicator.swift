//
//  
//  AndesProgressIndicator.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

@objc public class AndesProgressIndicator: UIView {
    internal var contentView: AndesProgressIndicatorView!

    @objc public var size: AndesProgressIndicatorSize = .large {
        didSet {
            updateContentView()
        }
    }

    @IBInspectable public var tint: UIColor? {
        didSet {
            updateContentView()
        }
    }

    @IBInspectable public var textColor: UIColor? {
        didSet {
            updateContentView()
        }
    }

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
        let size = AndesProgressIndicatorSizeFactory.provideStyle(key: self.size)
        let config = AndesProgressIndicatorViewConfigFactory.provideInternalConfig(textColor: .red, tint: .black, label: "test", size: size)
        contentView.update(withConfig: config)
    }

    /// Should return a view depending on which modifier is selected
    private func provideView() -> AndesProgressIndicatorView {
        let size = AndesProgressIndicatorSizeFactory.provideStyle(key: .small)
        let config = AndesProgressIndicatorViewConfigFactory.provideInternalConfig(textColor: .red, tint: .black, label: "test", size: size)
        return AndesProgressIndicatorViewDefault(withConfig: config)
    }
}

// MARK: - IB interface
public extension AndesProgressIndicator {
    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'Size' instead.")
    @IBInspectable var ibSize: String {
        set(val) {
            self.size = AndesProgressIndicatorSize.checkValidEnum(property: "IB size", key: val)
        }
        get {
            return self.size.toString()
        }
    }
}
