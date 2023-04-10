//
//  ViewForHeaderInSection.swift
//  Locator
//
//  Created by Алексей Бодров on 01.04.2023.
//

import Foundation

import UIKit

final class ViewForHeaderInSection: CommonInitView {
    // MARK: - constant
    private enum Constant {
        static let mainFontSize: CGFloat = .mSize
        static let discriptionFontSize: CGFloat = .sSize
    }

    // MARK: - property
    private let containerView = InformationView()

    // MARK: - life cycle funcs
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }

    // MARK: - public
    func setupWith(_ person: Person, discription: String) {
        containerView.setupWith(person, discription: discription)
    }

    override func commonInit() {
        addSubViews()
        configureView()
        setConstraints()
    }
}

extension ViewForHeaderInSection {

    // MARK: - flow funcs

    func addSubViews() {
        addSubview(containerView)
    }

    func configureView() {
        containerView.configureWith(mainFontSize: Constant.mainFontSize,
                                    discriptionFontSize: Constant.discriptionFontSize)
    }

    func setConstraints() {
        containerView.viewAnchors(self)
    }
}
