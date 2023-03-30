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
    private let view = InformationView().instanceFromNib()

    // MARK: - life cycle funcs
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }

    // MARK: - public
    func setupWith(image: String?, mainLabel: String?, discriptionLabel: String?) {
        self.view.setupWith(image: image, mainLabel: mainLabel, discriptionLabel: discriptionLabel)
    }
}

extension MainTableViewCell {

    // MARK: - flow funcs
    private func configureView() {
        self.contentView.addSubview(view)
        view.configureWith(mainFontSize: Constant.mainFontSize,
                           discriptionFontSize: Constant.discriptionFontSize)
        view.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setConstraint() {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
