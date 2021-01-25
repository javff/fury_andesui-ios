//
//  AndesTooltipRouter.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 22-01-21.
//  Copyright © 2021 MercadoLibre. All rights reserved.
//

import Foundation
import UIKit

protocol AndesTooltipRouterProtocol: NSObject {
    func route(from: UIViewController)
}

class TooltipRouter: NSObject {
    var view: AndesTooltipViewController!
}

extension TooltipRouter: AndesTooltipRouterProtocol {
    func route(from: UIViewController) {
        view = AndesTooltipViewController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
