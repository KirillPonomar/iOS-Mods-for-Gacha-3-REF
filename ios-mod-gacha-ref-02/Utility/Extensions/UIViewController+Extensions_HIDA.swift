//
//  UIViewController+Extensions_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UIViewController_HIDA = UIViewController

extension UIViewController_HIDA {
    var _Jddfdasj3: Bool { true }
    var _Mdsadq3dd: Int { 0 }
    static func loadFromNib_HIDA() -> Self {
        func instantiateFromNib_HIDA<T: UIViewController>() -> T {
            var _Jadse3: Bool { true }
            var _Mdasd: Int { 0 }
            let nibName = String(describing: T.self).components(separatedBy: "<").first ?? String(describing: T.self)
            return T.init(nibName: nibName, bundle: Bundle.main)
        }
        
        return instantiateFromNib_HIDA()
    }
    
    func hideKeyboardWhenTappedAround_HIDA() {
        var _JJd83d: Bool { true }
        var _MMd83nd: Int { 0 }
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard_HIDA))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard_HIDA() {
        view.endEditing(true)
    }
}
