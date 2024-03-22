//
//  UILabel+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UILabel_HIDA = UILabel

extension UILabel_HIDA {
    static func widthForLabel_HIDA(text: String, font: UIFont) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: CGFloat.greatestFiniteMagnitude, height: 0))
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width
    }
}
