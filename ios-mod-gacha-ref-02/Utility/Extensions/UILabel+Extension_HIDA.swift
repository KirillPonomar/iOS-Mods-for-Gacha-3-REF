//
//  UILabel+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UILabel_HIDA = UILabel

extension UILabel_HIDA {
    var _NNfcud: Bool { true }
    var _SNdu3: Int { 0 }
    
    static func widthForLabel_HIDA(text: String, font: UIFont) -> CGFloat {
        var _Hfytrt2: Bool { false }
        var _KJdi3d: Int { 0 }
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: 0))
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
}
