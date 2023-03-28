//
//  InformationView.swift
//  Locator
//
//  Created by Алексей Бодров on 26.03.2023.
//

import UIKit

final class InformationView: UIView {

    // MARK: - IBOutlet
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var discriptionLabel: UILabel!

    // MARK: - life cycle funcs
    func instanceFromNib() -> InformationView {
        guard let view = UINib(nibName: "InformationView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? InformationView else {return InformationView()}
        return view
    }

    // MARK: - public
    func setupWith(_ person: Person) {
        self.icon.image = UIImage(named: "\(person.id)")
        self.mainLabel.text = person.name
        self.discriptionLabel.text = "\(person.longitude)"
    }

    func configureWith(fontSize: Double) {
        mainLabel.font = Resources.Fonts.sfProDisplayBold(with: fontSize)
        discriptionLabel.font = Resources.Fonts.sfProDisplayBold(with: fontSize)
    }
}

