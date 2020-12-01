//
//  ProgressIndicatorRouter.swift
//  AndesUI-demoapp
//
//  Created by Juan Andres Vasquez Ferrer on 30-11-20.
//  Copyright © 2020 MercadoLibre. All rights reserved.
//

import Foundation
import UIKit

protocol ProgressIndicatorRouter: NSObject {
    func route(from: UIViewController)
}

class ProgressIndicatorAppRouter: NSObject {
    var view: ProgressIndicatorViewController!
}

extension ProgressIndicatorAppRouter: ProgressIndicatorRouter {
    func route(from: UIViewController) {
        view = ProgressIndicatorViewController()
        from.navigationController?.pushViewController(view, animated: true)
    }
}
