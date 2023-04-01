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
        let locationService = LocationService()
        let mainViewModel = MainViewModel(networkService: networkService,
                                          locationService: locationService)
        let mainView = MainView()
        let viewController = MainViewController(mainViewModel: mainViewModel,
                                                mainView: mainView)
        return viewController
    }
}
