//
//  AndesTooltipViewController.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 22-01-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import UIKit
import AndesUI

class AndesTooltipViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func rightBottomButtonTapped(_ sender: UIButton) {
        let xx = AndesTooltip(lightStyle: "Lorem it sum")
        xx.show(in: sender, within: contentView)
    }

    @IBAction func leftBottomButtonTapped(_ sender: UIButton) {
        let action = AndesTooltipAction(text: "link action", onPressed: {

        })
        let xx = AndesTooltip(lightStyle: "lorem it sum lorem it sumlorem it sumlorem it sumlorem it sumlorem it sum", title: "My title ", isDismissable: true, linkAction: action)
        xx.show(in: sender, within: contentView)
    }

    @IBAction func rightTopButtonTapped(_ sender: UIButton) {
        let xx = AndesTooltip(lightStyle: "Lorem it sum")
        xx.show(in: sender, within: contentView)
    }

    @IBAction func leftTopButtonTapped(_ sender: UIButton) {
        let xx = AndesTooltip(lightStyle: "sum Lorem it fin sum Lorem it finsum Lorem it finsum Lorem it finsum Lorem it finsum Lorem it finsum Lorem it fin")
        xx.show(in: sender, within: contentView)
    }

    @IBAction func centerButtonTapped(_ sender: UIButton) {
        let action = AndesTooltipAction(text: "link action", onPressed: {

        })
        let xx = AndesTooltip(lightStyle: "sum Lorem it fin sum Lorem it finsum Lorem it finsum Lorem it finsum Lorem it finsum Lorem it finsum Lorem it fin ", title: "My title", isDismissable: true, primaryQuietAction: action)
        xx.show(in: sender, within: contentView)
    }
}
