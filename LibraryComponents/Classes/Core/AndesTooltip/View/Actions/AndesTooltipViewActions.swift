//
//  AndesTooltipViewLink.swift
//  AndesUI
//
//  Created by Juan Andres Vasquez Ferrer on 09-02-21.
//

import Foundation

class AndesTooltipViewActions: AndesTooltipAbstractView {

    @IBOutlet weak var secondaryAction: AndesButton!
    @IBOutlet weak var primaryAction: AndesButton!
    override func loadNib() {
        let bundle = AndesBundle.bundle()
        bundle.loadNibNamed("AndesTooltipViewActions", owner: self, options: nil)
    }

    override func updateView() {
        super.updateView()
        self.updatePrimaryAction()
        self.updateSecondaryActionIfNeeded()
    }

    private func updatePrimaryAction() {
        if let primaryActionConfig = config.primaryActionConfig {
            primaryAction.updateWithCustomConfig(primaryActionConfig)
        }
    }

    private func updateSecondaryActionIfNeeded() {
        guard let secondaryActionConfig = config.secondaryActionConfig else {
            hideSecondaryButton()
            return
        }
        secondaryAction.updateWithCustomConfig(secondaryActionConfig)
    }

    private func hideSecondaryButton() {
        secondaryAction.removeFromSuperview()
    }

    @IBAction func primaryActionButtonTapped(_ sender: Any) {
        config.primaryActionOnPressed?()
        dismiss()
    }

    @IBAction func secondaryActionButtonTapped(_ sender: Any) {
        config.secondaryActionOnPressed?()
        dismiss()
    }
}
