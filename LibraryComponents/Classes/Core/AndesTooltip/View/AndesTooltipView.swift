//
//  
//  AndesTooltipView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesTooltip
 */
internal protocol AndesTooltipView: UIView {
    func update(withConfig config: AndesTooltipViewConfig)
    func show(in view: UIView, within superView: UIView)
}
