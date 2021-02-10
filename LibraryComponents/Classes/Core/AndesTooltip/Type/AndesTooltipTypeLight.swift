//
//  
//  AndesTooltipTypeLight.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

class AndesTooltipTypeLight: AndesTooltipTypeProtocol {
    var textColor: UIColor = UIColor.Andes.graySolid800
    var backgroundColor: UIColor = UIColor.Andes.white
    var maxWidth: CGFloat = 260
    var shadowOffset: CGSize = CGSize(width: 0, height: 0)
    var shadowRadius: CGFloat = 6
    var shadowOpacity: CGFloat = 0.3
    var closeButtonColor: UIColor = UIColor.Andes.graySolid800
}
