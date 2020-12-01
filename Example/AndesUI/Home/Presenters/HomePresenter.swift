//
//  HomePresenter.swift
//  AndesUI_Example
//
//  Created by Santiago Lazzari on 19/12/2019.
//  Copyright © 2019 MercadoLibre. All rights reserved.
//

import UIKit

protocol HomePresenter: NSObject {
    func presentProgressIndicator()
    func presentCoachmark()
    func presentButtons()
    func presentMessages()
    func presentTextField()
    func presentBadges()
    func presentWhatsNew()
    func presentCheckbox()
    func presentRadioButton()
    func presentTags()
    func presentSnackbar()
    func presentCard()
    func presentThumbnail()
    func presentTextFieldsCode()
    func presentDatePicker()
    func presentBottomSheet()
    func presentList()
}

class HomeViewPresenter: NSObject {

    unowned let view: HomeView
    unowned let router: HomeRouter

    init(view: HomeView, router: HomeRouter) {
        self.view = view
        self.router = router
    }
}

extension HomeViewPresenter: HomePresenter {

    func presentProgressIndicator() {
        router.routeToProgressIndicator()
    }

    func presentCoachmark() {
        router.routeToCoachmark()
    }

    func presentButtons() {
        router.routeToButton()
    }

    func presentMessages() {
        router.routeToMessages()
    }

    func presentBadges() {
        router.routeToBadges()
    }

    func presentWhatsNew() {
        router.routeToWhatsNew()
    }

    func presentTextField() {
        router.routeTextField()
    }
    func presentCheckbox() {
        router.routerCheckbox()
    }
    func presentRadioButton() {
        router.routerRadioButton()
    }
    func presentTags() {
        router.routeTags()
    }

    func presentSnackbar() {
        router.routeSnackbar()
    }

    func presentCard() {
        router.routeCard()
    }

    func presentThumbnail() {
        router.routeToThumbnail()
    }

    func presentList() {
        router.routeToList()
    }

    func presentTextFieldsCode() {
        router.routeToTextFieldsCode()
    }

    func presentDatePicker() {
        router.routeToDatePicker()
    }

    func presentBottomSheet() {
        router.routeToBottomSheet()
    }
}
