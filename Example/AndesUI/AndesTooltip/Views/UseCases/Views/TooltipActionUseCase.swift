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

struct TooltipDataShowCase {
    var content: String
    var title: String?
    var isDissmisable: Bool
    var tooltipType: AndesTooltipType?

    var primaryActionStyle: TooltipActionType?
    var primayActionText: String?
    var secondaryActionStyle: TooltipActionType?
    var secondaryActionText: String?

    func isValid() -> Bool {
        return !content.isEmpty && tooltipType != nil
    }
}

protocol TooltipActionUseCaseDataSource: class {
    func supportTypes() -> [TooltipActionType]
    func titleForType() -> String
}

protocol TooltipActionUseCaseDelegate: class {
    func tooltipCases(_ tooltipCase: TooltipActionUseCase, didSelectCase selectedCase: TooltipActionType)
}

class TooltipActionUseCase: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!

    let typePicker = UIPickerView()

    weak var dataSource: TooltipActionUseCaseDataSource? {
        didSet {
            self.reloadData()
        }
    }

    weak var delegate: TooltipActionUseCaseDelegate?

    private var actionTypes: [TooltipActionType] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupNib()
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupNib()
        setupView()
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
        self.delegate?.tooltipCases(self, didSelectCase: selectedType)
    }
}
