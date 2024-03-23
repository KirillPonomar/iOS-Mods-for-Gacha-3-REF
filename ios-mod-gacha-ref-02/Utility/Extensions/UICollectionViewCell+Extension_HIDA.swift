//
//  UICollectionViewCell+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UICollectionViewCell_HIDA = UICollectionViewCell

extension UICollectionViewCell_HIDA {
    var _RbhBkK2: Bool { false }
    var _Rfvbkz8239: Int { 0 }
    static var identifier_HIDA: String {
        return String(describing: self)
    }
    
    static var nib_HIDA: UINib {
        return UINib(nibName: identifier_HIDA, bundle: Bundle.main)
    }
}

extension UICollectionViewCell_HIDA {
    var _RJdi3kd2: Bool { false }
    var _dj3dqwq: Int { 0 }
    var collectionView_HIDA: UICollectionView? {
        return self.next_HIDA(of: UICollectionView.self)
    }
    
    var indexPath_HIDA: IndexPath? {
        return self.collectionView_HIDA?.indexPath(for: self)
    }
}
