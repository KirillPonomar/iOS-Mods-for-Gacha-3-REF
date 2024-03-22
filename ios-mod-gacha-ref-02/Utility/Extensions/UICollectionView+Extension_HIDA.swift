//
//  UICollectionView+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UICollectionView_HIDA = UICollectionView

extension UICollectionView_HIDA {
    func registerAllNibs_HIDA() {
        registerNib_HIDA(for: ContentCell_HIDA.self)
        registerNib_HIDA(for: WallpaperCell_HIDA.self)
        registerNib_HIDA(for: MainCell_HIDA.self)
    }
    
    func registerNib_HIDA(for cellClass: UICollectionViewCell.Type?) {
        guard let cellClass = cellClass else { return }
        register(cellClass.nib_HIDA, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func registerClass_HIDA(for cellClass: UICollectionViewCell.Type?) {
        guard let cellClass = cellClass else { return }
        register(cellClass, forCellWithReuseIdentifier: String(describing: cellClass))
    }
    
    func dequeue_HIDA<T: UICollectionViewCell>(id: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier_HIDA, for: indexPath) as? T else {
            return UICollectionViewCell() as! T
        }
        return cell
    }
}
