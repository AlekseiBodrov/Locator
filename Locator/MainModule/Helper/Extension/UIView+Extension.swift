//
//  UIView+Extension.swift
//  Locator
//
//  Created by Алексей Бодров on 28.03.2023.
//

import UIKit

extension UIView {
    func rounded(radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }

    func viewAnchors(_ superView: UIView,
                     topConstant: Double = 0,
                     leadingConstant: Double = 0,
                     trailingConstant: Double = 0,
                     bottomConstant: Double = 0) {

        self.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: superView.topAnchor,
                                    constant: topConstant),
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor,
                                        constant: leadingConstant),
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor,
                                         constant: trailingConstant),
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor,
                                       constant: bottomConstant)
        ])
    }
}
