//
//  AndesButtonView.swift
//  AndesUI
//
//  Created by LEANDRO FURYK on 26/12/2019.
//

import Foundation
/**
 Internal protocol that specifies the behaviour a view must provide to be a valid representation of an AndesButton
 */
internal protocol AndesButtonView: UIControl {

    func enable()
    func disable()

    func touchUp()
    func touchDown()

    func setText(_ text: String)

    func startSpinnerAnimation()
    func stopSpinnerAnimation()

}
