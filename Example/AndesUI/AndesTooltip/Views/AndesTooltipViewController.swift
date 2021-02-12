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

    @IBOutlet weak var configButton: AndesButton!
    @IBOutlet weak var configViewZeroConstraint: NSLayoutConstraint!
    @IBOutlet weak var configStackContainerView: UIStackView!
    @IBOutlet weak var configViewContainer: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var configView: UIView!
    @IBOutlet weak var updateConfig: AndesButton!
    @IBOutlet weak var dismissibleSwitch: UISwitch!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var useCasePrimaryActionContainer: UIStackView!
    @IBOutlet weak var useCaseSecondaryActionContainer: UIStackView!

    var typePicker: UIPickerView = UIPickerView()

    var primaryActionTooltipCase: TooltipActionUseCase?
    var secondaryActionTooltipCase: TooltipActionUseCase?
    var tooltip: AndesTooltip?

    lazy var dataShowCase: TooltipDataShowCase = {
        return TooltipDataShowCase(
            content: self.contentTextView.text,
            title: nil,
            isDissmisable: self.dismissibleSwitch.isOn,
            primaryActionStyle: nil,
            primayActionText: nil,
            secondaryActionStyle: nil,
            secondaryActionText: nil)
    }() {
        didSet {
            self.updateConfig.isEnabled = dataShowCase.isValid()
        }
    }

    var selectedType: AndesTooltipType? {
        didSet {
            guard let type = selectedType else { return }
            self.dataShowCase.tooltipType = type
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePicker()
        setupView()
        setupEvents()
        setupDefaultCase()
    }

    private func setupView() {
        self.updateConfig.isEnabled = false
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.layer.borderWidth = 1
        self.configStackContainerView.isHidden = true
        self.updateConfigView(hide: true)
    }

    private func setupDefaultCase() {
        self.pickerView(self.typePicker, didSelectRow: 0, inComponent: 0)
    }

    private func setupEvents() {
        self.dismissibleSwitch.addTarget(self, action: #selector(self.switchValueChanged(_:)), for: .valueChanged)

        self.titleTextField.addTarget(self, action: #selector(self.titleTextFieldChanged(_:)), for: .editingChanged)

        self.contentTextView.delegate = self

    }

    @objc func switchValueChanged(_ switchComponent: UISwitch) {
        self.dataShowCase.isDissmisable = switchComponent.isOn
    }

    @objc func titleTextFieldChanged(_ textField: UITextField) {
        self.dataShowCase.title = textField.text
    }

    @IBAction func configButtonTapped(_ sender: Any) {
        let hide = !self.configStackContainerView.isHidden
        self.updateConfigView(hide: hide)
    }

    private func updateConfigView(hide: Bool) {
        UIView.transition(with: configView, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.configStackContainerView.isHidden = hide
        }) { (_) in
            if hide {
                self.scrollView.setContentOffset(.zero, animated: true)
            } else {
                self.scrollView.scrollRectToVisible(self.configView.frame, animated: true)
            }
        }

        if self.configStackContainerView.isHidden {
            self.configButton.text = "change config"
            self.configButton.hierarchy = .quiet
        } else {
            self.configButton.text = "hide config"
            self.configButton.hierarchy = .transparent
        }
    }

    @IBAction func updateConfigButtonTapped(_ sender: Any) {
        self.updateConfigView(hide: true)
    }

    private func configurePicker() {
        typeField.inputView = typePicker
        typePicker.delegate = self
        typePicker.dataSource = self
    }

    @IBAction func showTooltipButtonTapped(_ sender: UIButton) {
        tooltip?.dismiss()
        let factory = selectedType?.getFactoryTooltip()
        tooltip = factory?.buildTooltip(using: dataShowCase)
        tooltip?.show(in: sender, within: self.scrollView)
    }

}

extension AndesTooltipViewController: UIPickerViewDataSource, UIPickerViewAccessibilityDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AndesTooltipType.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = AndesTooltipType.allCases[row].toString()
        return titleRow
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = AndesTooltipType.allCases[row]
        typeField.text = selectedType?.toString()
        self.view.endEditing(true)

        self.updatePrimaryActionUseCase()
    }
}

// MARK: - update options
extension AndesTooltipViewController: TooltipActionUseCaseDelegate {

    func updatePrimaryActionUseCase() {

        useCaseSecondaryActionContainer.subviews.forEach { $0.removeFromSuperview()
        }
        useCasePrimaryActionContainer.subviews.forEach { $0.removeFromSuperview()
        }

        let view = TooltipActionUseCase()
        view.dataSource = self.selectedType?.getUseCaseForPrimaryAction()
        view.delegate = self
        useCasePrimaryActionContainer.addArrangedSubview(view)
        self.primaryActionTooltipCase = view
    }

    func updateSecondaryActionUseCase(selectedCase: TooltipActionType) {
        useCaseSecondaryActionContainer.subviews.forEach { $0.removeFromSuperview()
        }
        guard let selectedType = self.selectedType,
        selectedType.hasSecondaryAction(for: selectedCase) else { return }

        let view = TooltipActionUseCase()
        view.dataSource = self.selectedType?.getUseCaseForSecondaryAction(primaryAction: selectedCase)
        view.delegate = self
        useCaseSecondaryActionContainer.addArrangedSubview(view)
        self.secondaryActionTooltipCase = view
    }

    func tooltipCase(_ tooltipCase: TooltipActionUseCase, didSelectCase selectedCase: TooltipActionType) {

        if tooltipCase === self.primaryActionTooltipCase {
            self.dataShowCase.primaryActionStyle = selectedCase
            self.updateSecondaryActionUseCase(selectedCase: selectedCase)
        }

        if tooltipCase === self.secondaryActionTooltipCase {
            self.dataShowCase.secondaryActionStyle = selectedCase
        }
    }

    func tooltipCase(_ tooltipCase: TooltipActionUseCase, updateInfo titleInfo: String?) {
        if tooltipCase === self.primaryActionTooltipCase {
            self.dataShowCase.primayActionText = titleInfo
        }

        if tooltipCase === self.secondaryActionTooltipCase {
            self.dataShowCase.secondaryActionText = titleInfo
        }
    }

}

extension AndesTooltipType {
    func getUseCaseForPrimaryAction() -> TooltipActionUseCaseDataSource? {
        switch self {
        case .dark:
            return TooltipActionDarkUseCase()
        case .light:
            return TooltipLightPrimaryCases()
        case .highlight:
            return TooltipActionHighlightUseCase()
        }
    }

    func getUseCaseForSecondaryAction(primaryAction: TooltipActionType) -> TooltipActionUseCaseDataSource? {
        switch self {
        case .dark:
            return TooltipDarkSecondaryCase(primaryAction: primaryAction)
        case .light:
            return TooltipLightSecondaryCases(primaryAction: primaryAction)
        case .highlight:
            return TooltipHighlightSecondaryCase(primaryAction: primaryAction)
        }
    }

    func getFactoryTooltip() -> TooltipAbstractFactory {
        switch self {
        case .light:
            return TooltipLightFactory()
        case .dark:
            return TooltipDarkFactory()
        case .highlight:
            return TooltipHighlightFactory()
        }
    }

    func hasSecondaryAction(for primaryAction: TooltipActionType) -> Bool {
        guard let useCases = self.getUseCaseForSecondaryAction(primaryAction: primaryAction) else { return false }
        return useCases.supportTypes().count >  0
    }
}

extension AndesTooltipViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.dataShowCase.content = textView.text
    }
}
