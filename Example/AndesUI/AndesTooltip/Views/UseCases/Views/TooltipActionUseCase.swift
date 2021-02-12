//
//  TooltipActionUseCase.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 10-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

enum TooltipActionType: String, CaseIterable {
    case loud = "loud"
    case quiet = "quiet"
    case transparent = "transparent"
    case link = "link"
}

protocol TooltipActionUseCaseDataSource: class {
    func supportTypes() -> [TooltipActionType]
    func titleForType() -> String
}

protocol TooltipActionUseCaseDelegate: class {
    func tooltipCase(_ tooltipCase: TooltipActionUseCase, didSelectCase selectedCase: TooltipActionType)

    func tooltipCase(_ tooltipCase: TooltipActionUseCase, updateInfo titleInfo: String?)
}

class TooltipActionUseCase: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!

    let typePicker = UIPickerView()

    weak var dataSource: TooltipActionUseCaseDataSource? {
        didSet {
            self.reloadData()
        }
    }

    weak var delegate: TooltipActionUseCaseDelegate?

    private var actionTypes: [TooltipActionType] = []

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupNib()
        setupView()
        setupEvents()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNib()
        setupView()
        setupEvents()
    }

    private func setupNib() {
        let className = String(describing: type(of: self))
        let nib = UINib(nibName: className, bundle: nil)

        guard let nibView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            return
        }

        addSubview(nibView)
        nibView.translatesAutoresizingMaskIntoConstraints = false
        nibView.pinTo(view: self)
    }

    private func setupView() {
        typeTextField.inputView = typePicker
        typePicker.delegate = self
        typePicker.dataSource = self
    }

    private func setupEvents() {
        self.titleTextField.addTarget(self, action: #selector(self.titleDidChange(_:)), for: .editingChanged)
    }

    @objc func titleDidChange(_ textField: UITextField) {
        self.delegate?.tooltipCase(self, updateInfo: textField.text)
    }

    private func reloadData() {
        self.actionTypes = dataSource?.supportTypes() ?? []
        let actionTitle = dataSource?.titleForType()

        self.titleLabel.text = "Set info of \(actionTitle ?? "")"
    }
}

extension TooltipActionUseCase: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return actionTypes.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleRow = actionTypes[row].rawValue
        return titleRow
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedType = actionTypes[row]
        typeTextField.text = selectedType.rawValue
        self.delegate?.tooltipCase(self, didSelectCase: selectedType)
    }
}
