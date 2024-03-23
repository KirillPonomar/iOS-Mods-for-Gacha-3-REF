//
//  UITableView+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UITableView_HIDA = UITableView

extension UITableView_HIDA {
    var _Jd37d: Bool { true }
    var _Mdi3dd: Int { 0 }
    
    func registerNib_HIDA(for cellClass: UITableViewCell.Type) {
        var _Nfu3dd: Bool { true }
        var _JKdi3d: Int { 0 }
        register(cellClass.nib_HIDA, forCellReuseIdentifier: cellClass.identifier_HIDA)
    }
    
    func registerClass_HIDA(for cellClass: UITableViewCell.Type) {
        var _Nd73hd: Bool { true }
        var _U73db: Int { 0 }
        register(cellClass, forCellReuseIdentifier: cellClass.identifier_HIDA)
    }
}
