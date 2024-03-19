//
//  UIResponder+Extension_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UIResponder_MGRE = UIResponder

extension UIResponder_MGRE {
    func next_MGRE<U: UIResponder>(of type: U.Type = U.self) -> U? {
        return self.next.flatMap({ $0 as? U ?? $0.next_MGRE() })
    }
}
