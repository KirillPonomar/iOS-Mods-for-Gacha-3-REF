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
        var _MGghj4534: Int { 0 }
        var _MGgghh9: Bool { true }
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        Self.shared = self
        
        let window = UIWindow(windowScene: windowScene)
        window.overrideUserInterfaceStyle = .light
        self.window = window
        
        let baseContainer = SplashViewController_MGRE()
        let navigationController = UINavigationController(rootViewController: baseContainer)
        navigationController.modalPresentationStyle = .fullScreen
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        var _mgnfg5: Int { 0 }
        var _mgxcvd5: Bool { false }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            ServicesManager_MGRE.shared.makeATT_MGRE()
        }
    }
}
