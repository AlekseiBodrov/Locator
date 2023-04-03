//
//  MainTableViewCell.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    // MARK: - static
    static let identifier = "MainTableViewCell"

    // MARK: - constant
    private enum Constant {
        static let mainFontSize: CGFloat = .mSize
        static let discriptionFontSize: CGFloat = .sSize
    }

    // MARK: - property
    private let containerView = InformationView()

    // MARK: - life cycle funcs
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
    }

    // MARK: - public
    func setupWith(_ person: Person, discription: String) {
        containerView.setupWith(person, discription: discription)
    }
}

extension MainTableViewCell {

    // MARK: - flow funcs
    private func addSubViews() {
        contentView.addSubview(containerView)
    }

    private func configureView() {
        containerView.configureWith(mainFontSize: Constant.mainFontSize,
                           discriptionFontSize: Constant.discriptionFontSize)
    }

    private func setConstraints() {
        containerView.viewAnchors(self)
    }
}
