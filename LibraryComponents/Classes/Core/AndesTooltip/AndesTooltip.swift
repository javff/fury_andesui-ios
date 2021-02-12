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

    let type: AndesTooltipType
    let title: String?
    let content: String
    let isDismissable: Bool

    var primaryAction: AnesTooltipInternalAction?
    var secondaryAction: AnesTooltipInternalAction?

    public func show(in view: UIView, within superView: UIView) {
        self.contentView.show(in: view, within: superView)
    }

    public func dismiss() {
        self.contentView.dismiss()
    }

    // MARK: - Light variants
    public convenience init(
        lightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true
    ) {
        self.init(content: content, title: title, isDismissable: isDismissable, type: .light)
    }

    public convenience init(
        lightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryLoudAction: AndesTooltipAction
    ) {
        let primaryAction = AnesTooltipInternalAction(action: primaryLoudAction, type: .loud)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .light, primaryAction: primaryAction)
    }

    public convenience init(
        lightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryQuietAction: AndesTooltipAction
    ) {
        let primaryAction = AnesTooltipInternalAction(action: primaryQuietAction, type: .quiet)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .light, primaryAction: primaryAction)
    }

    public convenience init(
        lightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        linkAction: AndesTooltipAction
    ) {
        let primaryAction = AnesTooltipInternalAction(action: linkAction, type: .link)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .light, primaryAction: primaryAction)
    }

    public convenience init(
        lightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryLoudAction: AndesTooltipAction,
        secondaryTransparentAction: AndesTooltipAction

    ) {
        let primaryAction = AnesTooltipInternalAction(action: primaryLoudAction, type: .loud)
        let secondaryAction = AnesTooltipInternalAction(action: secondaryTransparentAction, type: .transparent)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .light, primaryAction: primaryAction, secondaryAction: secondaryAction)
    }

    public convenience init(
        lightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryQuietAction: AndesTooltipAction,
        secondaryQuietAction: AndesTooltipAction

    ) {
        let primaryAction = AnesTooltipInternalAction(action: primaryQuietAction, type: .quiet)
        let secondaryAction = AnesTooltipInternalAction(action: secondaryQuietAction, type: .quiet)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .light, primaryAction: primaryAction, secondaryAction: secondaryAction)
    }

    // MARK: - Dark style variants
    public convenience init(
        darkStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true
    ) {
        self.init(content: content, title: title, isDismissable: isDismissable, type: .dark)
    }

    public convenience init(
        darkStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryLoudAction: AndesTooltipAction
    ) {
        let primaryAction = AnesTooltipInternalAction(action: primaryLoudAction, type: .loud)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .dark, primaryAction: primaryAction)
    }

    public convenience init(
        darkStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        linkAction: AndesTooltipAction
    ) {
        let primaryAction = AnesTooltipInternalAction(action: linkAction, type: .link)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .dark, primaryAction: primaryAction)
    }

    public convenience init(
        darkStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryLoudAction: AndesTooltipAction,
        secondaryTransparentAction: AndesTooltipAction

    ) {
        let primaryAction = AnesTooltipInternalAction(action: primaryLoudAction, type: .loud)
        let secondaryAction = AnesTooltipInternalAction(action: secondaryTransparentAction, type: .transparent)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .dark, primaryAction: primaryAction, secondaryAction: secondaryAction)
    }

    // MARK: - Highlight style variants
    public convenience init(
        highlightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true
    ) {
        self.init(content: content, title: title, isDismissable: isDismissable, type: .highlight)
    }

    public convenience init(
        highlightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryLoudAction: AndesTooltipAction
    ) {
        let primaryAction = AnesTooltipInternalAction(action: primaryLoudAction, type: .loud)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .highlight, primaryAction: primaryAction)
    }

    public convenience init(
        highlightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        linkAction: AndesTooltipAction
    ) {
        let primaryAction = AnesTooltipInternalAction(action: linkAction, type: .link)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .highlight, primaryAction: primaryAction)
    }

    public convenience init(
        highlightStyle content: String,
        title: String? = nil,
        isDismissable: Bool = true,
        primaryLoudAction: AndesTooltipAction,
        secondaryTransparentAction: AndesTooltipAction

    ) {
        let primaryAction = AnesTooltipInternalAction(action: primaryLoudAction, type: .loud)
        let secondaryAction = AnesTooltipInternalAction(action: secondaryTransparentAction, type: .transparent)
        self.init(content: content, title: title, isDismissable: isDismissable, type: .highlight, primaryAction: primaryAction, secondaryAction: secondaryAction)
    }

    private init(
        content: String,
        title: String?,
        isDismissable: Bool,
        type: AndesTooltipType,
        primaryAction: AnesTooltipInternalAction? = nil,
        secondaryAction: AnesTooltipInternalAction? = nil) {

        self.content = content
        self.title = title
        self.isDismissable = isDismissable
        self.type = type
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
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

        let withActions = primaryAction != nil || secondaryAction != nil

        if withActions {
            return AndesTooltipViewLink(withConfig: config)
        }

        return AndesTooltipViewDefault(withConfig: config)
    }
}
