//
//  UITabBarItem+AndesBadgeExtension.swift
//  AndesUI
//
//  Created by Julián Lima on 22/01/2021.
//  Copyright © 2021 MercadoPago. All rights reserved.
//

@objc extension UITabBarItem {
    func setAndesBadge(with value: String?) {
        guard let value = AndesTabBarValueBuilder.build(in: self, for: value),
              let badgeView = getBadgeView() else {
            badgeValue = nil
            return
        }

        updateBadge(view: badgeView, value: value)
    }

    private func getBadgeView() -> UIView? {
        guard let parentView = self.value(forKey: "view") as? UIView else { return nil }

        for subview in parentView.subviews {
            if NSStringFromClass(subview.classForCoder) == "_UIBadgeView" {
                return subview
            }
        }

        return nil
    }

    private func updateBadge(view: UIView, value: String) {
        view.subviews.forEach { $0.removeFromSuperview() }

        badgeColor = .clear
        view.backgroundColor = .clear

        let pillView = AndesBadgePill(hierarchy: .loud, type: .error, border: .standard, size: .small, text: value)

        view.addSubview(pillView)

        pillView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        pillView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}
