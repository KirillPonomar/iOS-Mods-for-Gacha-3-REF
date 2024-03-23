//
//  UIResponder+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UIResponder_HIDA = UIResponder

extension UIResponder_HIDA {
    var _U872ujds: Bool { true }
    var _Bjdi22: Int { 0 }
    func next_HIDA<U: UIResponder>(of type: U.Type = U.self) -> U? {
        var _JNncjhd87s: Bool { true }
        var _Nd62737s: Int { 0 }
        return self.next.flatMap({ $0 as? U ?? $0.next_HIDA() })
    }
}
