//
//  InformationView.swift
//  Locator
//
//  Created by Алексей Бодров on 26.03.2023.
//

import UIKit
import CoreLocation

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
}

