//
//  
//  AndesProgressIndicatorViewDefault.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//
//

import UIKit

class AndesProgressIndicatorViewCircular: AndesProgressIndicatorAbstractView {

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesProgressIndicatorViewCircular", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
        self.containerView.progress = 1
    }
}
