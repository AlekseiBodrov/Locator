//
//  InformationView.swift
//  Locator
//
//  Created by Алексей Бодров on 26.03.2023.
//

import UIKit
import CoreLocation

final class InformationView: UIView {
    private enum Constant {
        static let padding: CGFloat = .sSize
    }

    // MARK: - IBOutlet
    let icon = UIImageView()
    let mainLabel = UILabel()
    let discriptionLabel = UILabel()

    // MARK: - public

    func setupWith(image: String?, mainLabel: String?, discriptionLabel: String?) {
        self.icon.image = image != nil ?  UIImage(named: image!) : UIImage(systemName: "questionmark.circle")
        self.mainLabel.text =  mainLabel != nil ?  mainLabel : "Empty"
        self.discriptionLabel.text =  discriptionLabel != nil ?  discriptionLabel : "Empty"
    }

    func configureWith(mainFontSize: Double, discriptionFontSize: Double, radius: CGFloat = 10) {
        mainLabel.font = Resources.Fonts.sfProDisplayBold(with: mainFontSize)
        discriptionLabel.font = Resources.Fonts.sfProDisplayBold(with: discriptionFontSize)
        icon.rounded(radius: radius)
    }

    func configureView() {
        addSubview(icon)
        addSubview(mainLabel)
        addSubview(discriptionLabel)

        icon.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor,
                                      constant: Constant.padding),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor,
                                         constant: -Constant.padding),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor,
                                          constant: Constant.padding),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor),

            mainLabel.topAnchor.constraint(equalTo: icon.topAnchor),
            mainLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor,
                                               constant: Constant.padding),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: Constant.padding),

            mainLabel.heightAnchor.constraint(equalTo: discriptionLabel.heightAnchor),

            discriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor,
                                                  constant: Constant.padding),
            discriptionLabel.bottomAnchor.constraint(equalTo: icon.bottomAnchor),
            discriptionLabel.leadingAnchor.constraint(equalTo: mainLabel.leadingAnchor),
            discriptionLabel.trailingAnchor.constraint(equalTo: mainLabel.trailingAnchor)
        ])
    }
}
