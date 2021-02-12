//
//  TooltipUseCaseProtocols.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 11-02-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import AndesUI

protocol TooltipActionUseCaseDataSource: class {
    func supportTypes() -> [TooltipActionType]
    func titleForType() -> String
}

protocol TooltipActionUseCaseDelegate: class {
    func tooltipCase(_ tooltipCase: TooltipActionUseCase, didSelectCase selectedCase: TooltipActionType)

    func tooltipCase(_ tooltipCase: TooltipActionUseCase, updateInfo titleInfo: String?)
}

protocol TooltipAbstractFactory: class {
    func buildTooltip(using showCase: TooltipDataShowCase) -> AndesTooltip?
}
