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

    // MARK: - property
    let view = UIView()

    // MARK: - awakeFromNib
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - flow funcs
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
}

