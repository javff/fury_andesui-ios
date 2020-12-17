//
//  AndesButtonViewConfig.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 22/01/2020.
//

import Foundation

/**
The AndesButtonViewConfig contains the differents customizable attributes of the view
*/
internal struct AndesButtonViewConfig {
    var backgroundColor: CGColor
    var pressedColor: CGColor
    var disableColor: CGColor

    var text: String
    var textColor: UIColor
    var textAttributes: [NSAttributedString.Key: Any]
    var textDisableColor: UIColor
    var font: UIFont

    var cornerRadius: CGFloat
    var height: CGFloat
    var padding: CGFloat

    var icon: UIImage?
    var iconColor: UIColor?
    var iconDisableColor: UIColor?

    var spinnerTintColor: UIColor
    var spinnerSize: AndesProgressIndicatorSize
}
