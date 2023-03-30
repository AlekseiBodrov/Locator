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

final class ModuleBuilder: Builder {

    // MARK: - static
    static func createMain() -> MainViewController {
        let networkService = NetworkService()
        let mainViewModel = MainViewModel(networkService: networkService)
        let mainView = MainView()
        let viewController = MainViewController()
        viewController.mainViewModel = mainViewModel
        viewController.mainView = mainView

        return viewController
    }
}
