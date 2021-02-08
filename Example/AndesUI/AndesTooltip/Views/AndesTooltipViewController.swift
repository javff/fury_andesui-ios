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
        let xx = AndesTooltip()
        xx.show(in: sender, within: contentView)
    }

    @IBAction func leftBottomButtonTapped(_ sender: UIButton) {
        let xx = AndesTooltip()
        xx.show(in: sender, within: contentView)
    }

    @IBAction func rightTopButtonTapped(_ sender: UIButton) {
        let xx = AndesTooltip()
        xx.show(in: sender, within: contentView)
    }

    @IBAction func leftTopButtonTapped(_ sender: UIButton) {
        let xx = AndesTooltip()
        xx.show(in: sender, within: contentView)
//        let asy = EasyTipView(text: "Lorem it sum Lorem it sum Lorem it sum Lorem it sum Lorem it sum Lorem it sum Lorem it sum Lorem it sum Lorem it sum Lorem it sum Lorem it sum")
//        asy.show(forView: sender)
    }

    @IBAction func centerButtonTapped(_ sender: UIButton) {
        let xx = AndesTooltip()
        xx.show(in: sender, within: contentView)
    }
}
