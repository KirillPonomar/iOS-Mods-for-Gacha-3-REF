//
//  Optional+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import Foundation

typealias Optional_HIDA = Optional

extension Optional_HIDA where Wrapped: Collection {
    var isNilOrEmpty_HIDA: Bool {
        return self?.isEmpty ?? true
    }
}
