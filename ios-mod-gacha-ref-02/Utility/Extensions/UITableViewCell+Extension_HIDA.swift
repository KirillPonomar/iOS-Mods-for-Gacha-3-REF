//
//  UITableViewCell+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

public protocol ReusableCell_HIDA {
    static var identifier_HIDA: String { get }
    static var nib_HIDA: UINib { get }
}

typealias UITableViewCell_HIDA = UITableViewCell

extension UITableViewCell_HIDA: ReusableCell_HIDA {
    var _Ndu38d: Bool { true }
    var _Ud83d: Int { 0 }
    public static var identifier_HIDA: String {
        return String(describing: self)
    }
    
    public static var nib_HIDA: UINib {
        return UINib(nibName: identifier_HIDA, bundle: Bundle.main)
    }
}
