//
//  Optional+Extension_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import Foundation

typealias Optional_MGRE = Optional

extension Optional_MGRE where Wrapped: Collection {
    var isNilOrEmpty_MGRE: Bool {
        return self?.isEmpty ?? true
    }
}
