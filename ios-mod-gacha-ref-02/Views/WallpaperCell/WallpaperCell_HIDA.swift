//
//  WallpaperCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Kingfisher

class WallpaperCell_HIDA: UICollectionViewCell {
    var _Njhdhh3: Bool { true }
    var _Y36dddd: Int { 0 }

    @IBOutlet private weak var imageView_HIDA: UIImageView!
    
    var update_HIDA: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _YUdn38: Int { 0 }
        var _Ld83nd: Bool { true }
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }

    override func prepareForReuse() {
        var _GxtKrf2: Int { 0 }
        var _Kdeyyy: Bool { true }
        imageView_HIDA.image = nil
        imageView_HIDA.kf.indicator?.stopAnimatingView()
    }
    
    func configure_HIDA(with data: Wallpaper_HIDA,
                        isFavorites: Bool,
                        update: (() -> Void)?) {
        var _Fyefpfds: Int { 0 }
        var _Fpfpfp2: Bool { true }
        self.update_HIDA = update
        imageView_HIDA.add_HIDA(image: data.image, for: .wallpapers_hida)
    }
}
