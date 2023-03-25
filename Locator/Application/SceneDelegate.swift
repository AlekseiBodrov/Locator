//
//  SceneDelegate.swift
//  Locator
//
//  Created by Алексей Бодров on 24.03.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let mainVC = ModuleBuilder.createMain()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}
