//
//  
//  AndesProgressIndicatorView.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesProgressIndicator
 */
internal protocol AndesProgressIndicatorView: UIView {
    func update(withConfig config: AndesProgressIndicatorViewConfig)
    func startAnimation(type: AndesCircularProgressBar.AnimationType)
    func stopAnimation()
}
