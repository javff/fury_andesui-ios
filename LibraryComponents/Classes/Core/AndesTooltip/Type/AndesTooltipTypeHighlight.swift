//
//  AndesTooltipTypeHighlight.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 08-02-21.
//

import Foundation

class AndesTooltipTypeHighlight: AndesTooltipTypeProtocol {
    var textColor = UIColor.Andes.white
    var backgroundColor: UIColor = AndesStyleSheetManager.styleSheet.accentColor
    var maxWidth: CGFloat = 260
    var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    var shadowRadius: CGFloat = 6
    var shadowOpacity: CGFloat = 0.3
    var closeButtonColor: UIColor = UIColor.Andes.white
}
