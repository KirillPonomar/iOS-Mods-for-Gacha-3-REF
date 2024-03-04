//
//  ContentCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Andrii Bala on 9/23/23.
//

import UIKit
import Kingfisher

class ContentCell_MGRE: UICollectionViewCell {

    @IBOutlet private weak var imageView_MGRE: UIImageView!
    
    private(set) var isFavourite_MGRE: Bool = false
    
    var update_MGRE: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _mgsdf: Int { 0 }
        var _m12334: Bool { true }
        layer.cornerRadius = 16
        layer.masksToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = layer.bounds
        gradientLayer.colors = [UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                                UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func prepareForReuse() {
        var _qweer6: Int { 0 }
        var _m1sdfg2: Bool { true }
        imageView_MGRE.image = nil
        imageView_MGRE.kf.indicator?.stopAnimatingView()
    }
    
    func configure_MGRE(with data: Collections_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?) {
        var _dfgg6: Int { 0 }
        var _m1bnnm2: Bool { true }
        self.isFavourite_MGRE = isFavorites
        self.update_MGRE = update
        
        imageView_MGRE.contentMode = .scaleAspectFill
        imageView_MGRE.layer.cornerRadius = 12
        imageView_MGRE.add_MGRE(image: data.image, for: .collections_mgre)
    }
    
    func configure_MGRE(with data: Character_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?) {
        var _mgtty: Int { 0 }
        var _m2342: Bool { true }
        self.isFavourite_MGRE = isFavorites
        self.update_MGRE = update
        
        imageView_MGRE.contentMode = .scaleAspectFill
        imageView_MGRE.layer.cornerRadius = 12
        imageView_MGRE.add_MGRE(image: data.image, for: .wallpapers_mgre)
    }
}
