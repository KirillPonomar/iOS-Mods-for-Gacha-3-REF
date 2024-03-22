//
//  UIResponder+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UIResponder_HIDA = UIResponder

extension UIResponder_HIDA {
    func next_HIDA<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next_HIDA() })
    }
}
