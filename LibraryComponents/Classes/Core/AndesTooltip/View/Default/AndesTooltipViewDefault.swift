//
//  
//  AndesTooltipViewDefault.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

class AndesTooltipViewDefault: AndesTooltipAbstractView {

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesTooltipViewDefault", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }

}
