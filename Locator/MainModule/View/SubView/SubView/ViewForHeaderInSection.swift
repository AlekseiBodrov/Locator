//
//  ViewForHeaderInSection.swift
//  Locator
//
//  Created by Алексей Бодров on 01.04.2023.
//

import Foundation

import UIKit

final class ViewForHeaderInSection: UIView {
    // MARK: - constant
    private enum Constant {
        static let mainFontSize: CGFloat = .mSize
        static let discriptionFontSize: CGFloat = .mSize
    }

    // MARK: - property
    private let containerView = InformationView()

    // MARK: - life cycle funcs

//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
        setConstraints()
        containerView.setConstraints()
    }

    // MARK: - public
    func setupWith(image: String?, mainLabel: String?, discriptionLabel: String?) {
        containerView.setupWith(image: image, mainLabel: mainLabel, discriptionLabel: discriptionLabel)
    }
}

extension ViewForHeaderInSection {

    // MARK: - flow funcs
    func configureView() {
        addSubview(containerView)
        containerView.configureWith(mainFontSize: Constant.mainFontSize,
                           discriptionFontSize: Constant.discriptionFontSize)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
