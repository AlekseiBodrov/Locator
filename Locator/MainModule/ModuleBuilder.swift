//
//  ModuleBuilder.swift
//  Locator
//
//  Created by Алексей Бодров on 25.03.2023.
//

import UIKit

protocol Builder {
    static func createMain() -> MainViewController
}

class ModuleBuilder: Builder {
    static func createMain() -> MainViewController {
        let viewController = MainViewController()
        return viewController
    }
}
