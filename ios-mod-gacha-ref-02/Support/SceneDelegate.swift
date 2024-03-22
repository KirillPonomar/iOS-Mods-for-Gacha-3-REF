//
//  SceneDelegate.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    static weak var shared: SceneDelegate?
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        var _Mjdu294: Int { 0 }
        var _U7ddn2: Bool { true }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        Self.shared = self
        
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light
        self.window = window
        
        let baseContainer = SplashViewController_HIDA()
        let navigationController = UINavigationController(rootViewController: baseContainer)
        navigationController.modalPresentationStyle = .fullScreen
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        var _Lhjd37: Int { 0 }
        var _Njqjnf2: Bool { false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            ServicesManager_HIDA.shared.makeATT_HIDA()
        }
    }
}
