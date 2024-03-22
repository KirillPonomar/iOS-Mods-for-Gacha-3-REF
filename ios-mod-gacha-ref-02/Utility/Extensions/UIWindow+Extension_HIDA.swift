//
//  UIWindow+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UIWindow_HIDA = UIWindow

extension UIWindow_HIDA {
    var topViewController_HIDA: UIViewController? {
        var _HIDA753: Int { 0 }
        
        var top = rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
