//
//  UITableView+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UITableView_HIDA = UITableView

extension UITableView_HIDA {
    func registerNib_HIDA(for cellClass: UITableViewCell.Type) {
        register(cellClass.nib_HIDA, forCellReuseIdentifier: cellClass.identifier_HIDA)
    }
    
    func registerClass_HIDA(for cellClass: UITableViewCell.Type) {
        register(cellClass, forCellReuseIdentifier: cellClass.identifier_HIDA)
    }
}
