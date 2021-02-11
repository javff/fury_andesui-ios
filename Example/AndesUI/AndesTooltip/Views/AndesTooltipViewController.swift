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

    var contentObserve: NSKeyValueObservation?
    var dismissObserve: NSKeyValueObservation?
    var typeFieldObserve: NSKeyValueObservation?

    lazy var dataShowCase: TooltipDataShowCase = {
        return TooltipDataShowCase(
            content: self.contentTextView.text,
            title: "",
            isDissmisable: self.dismissibleSwitch.isOn,
            tooltipType: nil,
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
            self.dataShowCase.tooltipType = selectedType
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePicker()
        setupView()
        setupDataBinding()
    }

    deinit {
        self.contentObserve?.invalidate()
        self.dismissObserve?.invalidate()
        self.typeFieldObserve?.invalidate()
    }

    private func setupView() {
        contentTextView.layer.borderColor = UIColor.lightGray.cgColor
        contentTextView.layer.borderWidth = 1
    }

    private func setupDataBinding() {
        self.contentObserve = contentTextView.observe(\.text) { (_, value) in
            self.dataShowCase.content = value.newValue ?? ""
        }

        self.dismissObserve = dismissibleSwitch.observe(\.isOn) { (_, value) in
            self.dataShowCase.isDissmisable = value.newValue ?? false
        }
    }

    private func configurePicker() {
        typeField.inputView = typePicker
        typePicker.delegate = self
        typePicker.dataSource = self
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

    func tooltipCases(_ tooltipCase: TooltipActionUseCase, didSelectCase selectedCase: TooltipActionType) {

        if tooltipCase === self.primaryActionTooltipCase {
            self.updateSecondaryActionUseCase(selectedCase: selectedCase)
        }

    }
}

extension AndesTooltipType {
    func getUseCaseForPrimaryAction() -> TooltipActionUseCaseDataSource? {
        switch self {
        case .dark:
            return TooltipLightPrimaryCases()
        case .light:
            return TooltipLightPrimaryCases()
        case .highlight:
            return TooltipLightPrimaryCases()
        }
    }

    func getUseCaseForSecondaryAction(primaryAction: TooltipActionType) -> TooltipActionUseCaseDataSource? {
        switch self {
        case .dark:
            return TooltipLightSecondaryCases(primaryAction: primaryAction)
        case .light:
            return TooltipLightSecondaryCases(primaryAction: primaryAction)
        case .highlight:
            return TooltipLightSecondaryCases(primaryAction: primaryAction)
        }
    }

    func hasSecondaryAction(for primaryAction: TooltipActionType) -> Bool {
        guard let useCases = self.getUseCaseForSecondaryAction(primaryAction: primaryAction) else { return false }
        return useCases.supportTypes().count >  0
    }
}
