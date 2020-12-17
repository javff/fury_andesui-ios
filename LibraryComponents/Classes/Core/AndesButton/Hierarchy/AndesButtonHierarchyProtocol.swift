//
//  AndesButtonStyle.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 17/12/2019.
//

import Foundation

internal protocol AndesButtonHierarchyProtocol {

    var idleColor: UIColor { get }
    var pressedColor: UIColor { get }
    var disableColor: UIColor { get }

    var fontColor: UIColor { get }

    var spinnerTintColor: UIColor { get }
}
