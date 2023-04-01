//
//  MainTableViewCell.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    // MARK: - constant
    private enum Constant {
        static let mainFontSize: CGFloat = .mSize
        static let discriptionFontSize: CGFloat = .sSize
    }

    // MARK: - static
    static let identifier = "MainTableViewCell"

    // MARK: - property
    private let containerView = InformationView()

    // MARK: - life cycle funcs
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
        containerView.configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraints()
        containerView.setConstraints()
    }

    // MARK: - public
    func setupWith(image: String?, mainLabel: String?, discriptionLabel: String?) {
        containerView.setupWith(image: image, mainLabel: mainLabel, discriptionLabel: discriptionLabel)
    }
}

extension MainTableViewCell {

    // MARK: - flow funcs
    private func configureView() {
        contentView.addSubview(containerView)
        containerView.configureWith(mainFontSize: Constant.mainFontSize,
                           discriptionFontSize: Constant.discriptionFontSize)
        containerView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
