//
//  HomeViewController.swift
//  AndesUI_Example
//
//  Created by Santiago Lazzari on 19/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import UIKit

import AndesUI

protocol HomeView: NSObject {

}

class HomeViewController: UIViewController {

    weak var presenter: HomePresenter!
    @IBOutlet weak var progressIndicatorBtn: AndesButton!
    @IBOutlet weak var coachmarkBtn: AndesButton!
    @IBOutlet weak var button: AndesButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var messagesBtn: AndesButton!
    @IBOutlet weak var badgesBtn: AndesButton!
    @IBOutlet weak var welcomeMessage: AndesMessage!
    @IBOutlet weak var radioButton: AndesButton!
    @IBOutlet weak var textFieldBtn: AndesButton!
    @IBOutlet weak var checkboxBtn: AndesButton!
    @IBOutlet weak var tagBtn: AndesButton!
    @IBOutlet weak var snackbarBtn: AndesButton!
    @IBOutlet weak var cardBtn: AndesButton!
    @IBOutlet weak var specsButton: AndesButton!
    @IBOutlet weak var contributingButton: AndesButton!
	@IBOutlet weak var thumbnailBtn: AndesButton!

	@IBOutlet weak var showcaseLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            showcaseLabel.text = "\("home.label.showcase".localized) (v\(version))"
        }

        setupUI()
    }

    private func setupUI() {
        func setupNavigation() {
            navigationItem.title = "AndesUI"
        }

        func setupMessage() {
            welcomeMessage.title = "home.welcomeMsg.title".localized
            welcomeMessage.body = "home.welcomeMsg.desc".localized
            welcomeMessage.setPrimaryAction("home.welcomeMsg.action".localized, handler: { _ in
                self.presenter.presentWhatsNew()
            })
        }

        func setupButtons() {
            specsButton.text = "Andes Specs 📘"
            contributingButton.text = "home.button.contribute.title".localized
        }

        setupButtons()
        setupNavigation()
        setupMessage()
    }

    @IBAction func goToCoachmarkWasTapped(_ sender: Any) {
        presenter.presentCoachmark()
    }

    @IBAction func goToButtonWasTapped(_ sender: Any) {
        presenter.presentButtons()
    }

    @IBAction func goToMessagesTapped(_ sender: Any) {
        presenter.presentMessages()
    }

    @IBAction func goToBadgesTapped(_ sender: Any) {
        presenter.presentBadges()
    }

    @IBAction func goToCheckboxTapped(_ sender: Any) {
        presenter.presentCheckbox()
    }

    @IBAction func goToRadioButtonTapped(_ sender: Any) {
        presenter.presentRadioButton()
    }

    @IBAction func goToDatePickerTapped(_ sender: Any) {
        presenter.presentDatePicker()
    }

    @IBAction func goToSpecsTapped(_ sender: Any) {
        guard let url = URL(string: "https://company-161429.frontify.com/d/kxHCRixezmfK/n-a") else { return }
        UIApplication.shared.open(url)

    }

    @IBAction func goToContributingTapped(_ sender: Any) {
        guard let url = URL(string: "https://meli.workplace.com/notes/andes-ui/c%C3%B3mo-contribuir-en-andes-ui/2559399620854933") else { return }
        UIApplication.shared.open(url)

    }

    @IBAction func progressIndicatorBtnTapped(_ sender: Any) {
        presenter.presentProgressIndicator()
    }

    @IBAction func textfieldBtnTapped(_ sender: Any) {
        presenter.presentTextField()
    }

    @IBAction func tagBtnTapped(_ sender: Any) {
        presenter.presentTags()
    }

    @IBAction func snackbarBtnTapped(_ sender: Any) {
        presenter.presentSnackbar()
    }

    @IBAction func cardBtnTapped(_ sender: Any) {
        presenter.presentCard()
    }

    @IBAction func goToThumbnailTapped(_ sender: Any) {
        presenter.presentThumbnail()
    }

    @IBAction func goToListViewTapped(_ sender: Any) {
        presenter.presentList()
    }

    @IBAction func goToTextFieldsCodeTapped(_ sender: Any) {
        presenter.presentTextFieldsCode()
    }

    @IBAction func bottomSheetTapped(_ sender: Any) {
        presenter.presentBottomSheet()
    }
}

extension HomeViewController: HomeView {

}
