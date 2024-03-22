//
//  WallpaperCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Kingfisher

class WallpaperCell_HIDA: UICollectionViewCell {

    @IBOutlet private weak var imageView_HIDA: UIImageView!
    
    var update_HIDA: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _d3d3s: Int { 0 }
        var _vasd3: Bool { true }
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }

    override func prepareForReuse() {
        var _mfbnnn: Int { 0 }
        var _m1eeeee: Bool { true }
        imageView_HIDA.image = nil
        imageView_HIDA.kf.indicator?.stopAnimatingView()
    }
    
    func configure_HIDA(with data: Wallpaper_HIDA,
                        isFavorites: Bool,
                        update: (() -> Void)?) {
        var _d4r4fds: Int { 0 }
        var _a888fs: Bool { true }
        self.update_HIDA = update
        imageView_HIDA.add_HIDA(image: data.image, for: .wallpapers_hida)
    }
}
