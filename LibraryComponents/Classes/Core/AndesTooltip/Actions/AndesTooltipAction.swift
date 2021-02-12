//
//  AndesTooltipAction.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 10-02-21.
//

import Foundation

public class AndesTooltipAction {
    let text: String
    var onPressed: (() -> Void)

    public init(text: String, onPressed: @escaping (() -> Void)) {
        self.text = text
        self.onPressed = onPressed
    }
}

internal enum AndesTooltipActionType {
    case loud
    case quiet
    case link
    case transparent
}

internal class AnesTooltipInternalAction {
    let text: String
    var onPressed: (() -> Void)
    let type: AndesTooltipActionType

    init(action: AndesTooltipAction, type: AndesTooltipActionType) {
        self.text = action.text
        self.onPressed = action.onPressed
        self.type = type
    }
}

internal class AndesTooltipActionFactory {

    class func provide(action: AnesTooltipInternalAction, tooltipType: AndesTooltipType) -> AndesButtonViewConfig {

        switch action.type {
        case .link:
            return createLinkConfig(action: action, tooltipType: tooltipType)
        case .loud:
            return createLoudConfig(action: action)
        case .quiet:
            return createQuietConfig(action: action)
        case .transparent:
            return createTransparentConfig(action: action)
        }
    }

    private class func createLoudConfig(action: AnesTooltipInternalAction) -> AndesButtonViewConfig {
        return AndesButtonViewConfigFactory.provide(hierarchy: .loud, size: .medium, text: action.text, icon: nil)
    }

    private class func createTransparentConfig(action: AnesTooltipInternalAction) -> AndesButtonViewConfig {
        return AndesButtonViewConfigFactory.provide(hierarchy: .transparent, size: .medium, text: action.text, icon: nil)
    }

    private class func createQuietConfig(action: AnesTooltipInternalAction) -> AndesButtonViewConfig {
        return AndesButtonViewConfigFactory.provide(hierarchy: .quiet, size: .medium, text: action.text, icon: nil)
    }

    private class func createLinkConfig(action: AnesTooltipInternalAction, tooltipType: AndesTooltipType) -> AndesButtonViewConfig {

        let textAttr = provideLinkAttr(tooltipType: tooltipType)
        let hierarchy = provideActionLinkHierachy(tooltipType: tooltipType)
        return AndesButtonViewConfigFactory.provide(
            hierarchy: hierarchy,
            size: AndesLinkButtonSizeMedium(),
            text: action.text,
            textattributes: textAttr,
            icon: nil)
    }

    private class func provideLinkAttr(tooltipType: AndesTooltipType) ->  [NSAttributedString.Key: Any] {
        switch tooltipType {
        case .dark, .highlight:
            return [.underlineStyle: NSUnderlineStyle.single.rawValue]
        case .light:
            return [:]
        }
    }

    private class func provideActionLinkHierachy(tooltipType: AndesTooltipType) -> AndesButtonHierarchyProtocol {
        switch tooltipType {
        case .dark, .highlight:
            return AndesTooltipActionLinkHierarchy(textColor: UIColor.Andes.white, pressedColor: UIColor.Andes.white)
        default:
            return AndesTooltipActionLinkHierarchy(textColor: UIColor.Andes.blueML800, pressedColor: .clear)
        }

    }

}
