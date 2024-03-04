//
//  Optional+Extension_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Andrii Bala on 11/7/23.
//

import Foundation

typealias Optional_MGRE = Optional

extension Optional_MGRE where Wrapped: Collection {
    var isNilOrEmpty_MGRE: Bool {
        return self?.isEmpty ?? true
    }
}
