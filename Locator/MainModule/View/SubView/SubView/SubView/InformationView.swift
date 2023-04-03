//
//  InformationView.swift
//  Locator
//
//  Created by Алексей Бодров on 26.03.2023.
//

import UIKit
import CoreLocation

final class InformationView: UIView {
    // MARK: - constant
    private enum Constant {
        static let padding: CGFloat = .sSize
    }

    // MARK: - property
    private let icon = UIImageView()
    private let mainLabel = UILabel()
    private let discriptionLabel = UILabel()

    // MARK: - life cycle funcs
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }

    // MARK: - public
    func setupWith(_ person: Person, discription: String) {
        self.icon.image = person.icon != nil ?
        UIImage(named: person.icon!) : UIImage(systemName: "questionmark.circle")

        self.mainLabel.text =  person.name != nil ?  person.name! : "Empty"

        self.discriptionLabel.text = discription
    }

    func configureWith(mainFontSize: Double,
                       discriptionFontSize: Double,
                       radius: CGFloat = 10) {
        mainLabel.font = Resources.Fonts.sfProDisplayBold(with: mainFontSize)
        discriptionLabel.font = Resources.Fonts.sfProDisplayBold(with: discriptionFontSize)
        discriptionLabel.numberOfLines = 0
        icon.rounded(radius: radius)
    }

    // MARK: - flow funcs
    private func commonInit() {
         addSubviews()
         setConstraints()
     }

    private func addSubviews() {
        addSubview(icon)
        addSubview(mainLabel)
        addSubview(discriptionLabel)
    }

    private func setConstraints() {
        icon.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor,
                                      constant: Constant.padding),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor,
                                          constant: Constant.padding),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor,
                                         constant: -Constant.padding),

            mainLabel.topAnchor.constraint(equalTo: topAnchor,
                                           constant: Constant.padding),
            mainLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor,
                                               constant: Constant.padding),
            mainLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                constant: -Constant.padding),

            discriptionLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor,
                                                  constant: Constant.padding),
            discriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                     constant: -Constant.padding),
            discriptionLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor,
                                                      constant: Constant.padding),
            discriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                       constant: -Constant.padding),
            discriptionLabel.heightAnchor.constraint(equalTo: mainLabel.heightAnchor)
        ])
    }
}
