//
//  UIViewController+Extensions_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UIViewController_HIDA = UIViewController

extension UIViewController_HIDA {
    static func loadFromNib_HIDA() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            let nibName = String(describing: T.self).components(separatedBy: "<").first ?? String(describing: T.self)
            return T.init(nibName: nibName, bundle: Bundle.main)
        }
        
        return instantiateFromNib()
    }
    
    func hideKeyboardWhenTappedAround_HIDA() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard_HIDA))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard_HIDA() {
        view.endEditing(true)
    }
}
