//
//  Resources.swift
//  Locator
//
//  Created by Алексей Бодров on 28.03.2023.
//

import UIKit

enum Resources {
    enum Alert {
        static let title = "Is empty"
        static let message = ""
        static let cancel = "Cancel"
    }

    enum Fonts {
        static func sfProDisplayBold(with size: CGFloat) -> UIFont {
            UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont()
        }
        static func sfProDisplayRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont()
        }
    }
}
