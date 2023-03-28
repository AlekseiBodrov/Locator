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
        static let fontSize: CGFloat = .mSize
    }

    // MARK: - static
    static let identifier = "MainTableViewCell"

    // MARK: - property
    let view = InformationView().instanceFromNib()

    // MARK: - life cycle funcs
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - flow funcs
    override func layoutSubviews() {
        super.layoutSubviews()
        setConstraint()
    }

    // MARK: - public
    func setupWith(_ person: Person) {
        self.view.setupWith(person)
    }
}

extension MainTableViewCell {

    // MARK: - flow funcs
    private func configureView() {
        self.contentView.addSubview(view)
        view.configureWith(fontSize: Constant.fontSize)
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
