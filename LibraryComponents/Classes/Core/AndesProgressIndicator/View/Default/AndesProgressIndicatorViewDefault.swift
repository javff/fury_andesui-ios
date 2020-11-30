//
//  
//  AndesProgressIndicatorViewDefault.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import Foundation

class AndesProgressIndicatorViewDefault: AndesProgressIndicatorAbstractView {
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesProgressIndicatorViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
