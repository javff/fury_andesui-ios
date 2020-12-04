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

    private let progressValue: CGFloat = 1

    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesProgressIndicatorViewCircular", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
        self.circularProgressBar.progress = progressValue
    }
}
