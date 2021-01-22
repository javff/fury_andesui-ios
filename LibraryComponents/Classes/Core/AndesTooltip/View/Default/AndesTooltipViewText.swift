//
//  
//  AndesTooltipViewDefault.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 19-01-21.
//
//

import Foundation

class AndesTooltipViewText: AndesTooltipAbstractView {

    @IBOutlet weak var contentLabel: UILabel!

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesTooltipViewText", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
    }
}
