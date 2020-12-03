//
//  ProgressIndicatorViewController.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class ProgressIndicatorViewController: UIViewController {

    @IBOutlet weak var progressIndicatorLargeWithText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorSmallWithText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorMediumWithText: AndesProgressIndicatorIndeterminate!

    @IBOutlet weak var progressIndicatorLargeWithoutText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorSmallWithoutText: AndesProgressIndicatorIndeterminate!
    @IBOutlet weak var progressIndicatorMediumWithoutText: AndesProgressIndicatorIndeterminate!

    override func viewDidLoad() {
        super.viewDidLoad()

        progressIndicatorLargeWithText.startAnimation()
        progressIndicatorSmallWithText.startAnimation()
        progressIndicatorMediumWithText.startAnimation()

        progressIndicatorLargeWithoutText.startAnimation()
        progressIndicatorSmallWithoutText.startAnimation()
        progressIndicatorMediumWithoutText.startAnimation()

    }

}
