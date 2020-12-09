//
//  AndesTextFieldIconView.swift
//  AndesUI
//
//  Created by Nicolas Rostan Talasimov on 4/1/20.
//

import UIKit
class AndesTextFieldIconView: UIView {
    private var iconColor: UIColor?
    private var icon: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    convenience init(iconColor: UIColor, icon: UIImage) {
        self.init()

        self.iconColor = iconColor
        self.icon = icon
        setUp()
    }

    func setUp() {
        guard let icon = self.icon, let iconColor = self.iconColor else {
            return
        }
        let imageView = UIImageView(image: icon)
        imageView.tintColor = iconColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.addSubview(imageView)
        imageView.pinToSuperview(top: 0, left: 12, bottom: 0, right: 12)
        self.isUserInteractionEnabled = false
    }
}
