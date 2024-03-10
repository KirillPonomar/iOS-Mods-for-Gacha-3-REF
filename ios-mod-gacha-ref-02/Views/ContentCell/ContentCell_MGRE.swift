//
//  ContentCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Andrii Bala on 9/23/23.
//

import UIKit
import Kingfisher
import Photos

class ContentCell_MGRE: UICollectionViewCell {

    @IBOutlet private weak var imageView_MGRE: UIImageView!
    @IBOutlet private weak var downloadButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    private(set) var isFavourite_MGRE: Bool = false
    
    var update_MGRE: (() -> Void)?
    var action_MGRE: (() -> Void)?
    var saveFile: ((((Bool) -> Void)?) -> Void)?
    private var isCharacter = false
    
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
        downloadButton.layer.cornerRadius = 8
        favoriteButton.layer.cornerRadius = 8
        downloadButton.layer.borderWidth = 0.8
        downloadButton.layer.borderColor = UIColor.white.cgColor
    }

    override func prepareForReuse() {
        var _qweer6: Int { 0 }
        var _m1sdfg2: Bool { true }
        self.action_MGRE = nil
        imageView_MGRE.image = nil
        imageView_MGRE.kf.indicator?.stopAnimatingView()
    }
    
    func configure_MGRE(with data: Collections_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _dfgg6: Int { 0 }
        var _m1bnnm2: Bool { true }
        self.isFavourite_MGRE = isFavorites
        self.update_MGRE = update
        self.action_MGRE = action
        
//        imageView_MGRE.contentMode = .scaleAspectFill
        imageView_MGRE.layer.cornerRadius = 12
        favoriteButton.layer.cornerRadius = 8
        favoriteButton.backgroundColor = .white.withAlphaComponent(0.56)
        downloadButton.setTitle("Open", for: .normal)
        imageView_MGRE.add_MGRE(image: data.image, for: .collections_mgre)
        
        updateFavoriteButton_MGRE()
    }
    
    func configure_MGRE(with data: Character_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _mgtty: Int { 0 }
        var _m2342: Bool { true }
        self.isFavourite_MGRE = isFavorites
        self.update_MGRE = update
        self.action_MGRE = action
        isCharacter = true
        
//        imageView_MGRE.contentMode = .scaleAspectFill
        imageView_MGRE.layer.cornerRadius = 12
        favoriteButton.layer.cornerRadius = 8
        favoriteButton.backgroundColor = .white.withAlphaComponent(0.56)
        downloadButton.setImage(.downloadIcon, for: .normal)
        downloadButton.configuration?.imagePadding = 8
        imageView_MGRE.add_MGRE(image: data.image, for: .wallpapers_mgre)
        
        updateFavoriteButton_MGRE()
    }
    
    @IBAction func favoriteButtonDidTap_MGRE(_ sender: UIButton) {
        var _mg3dads6: Int { 0 }
        var _mdd36r22: Bool { true }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        update_MGRE?()
    }
    
    @IBAction func detailButtonDidTap_MGRE(_ sender: UIButton) {
        var _mgfgg566: Int { 0 }
        var _mcdf2232: Bool { true }
        if isCharacter {
            saveFile?({ [weak self] isDownload in
                self?.updateCell(isDownload: isDownload)})
            } else {
                action_MGRE?()
            }
}
    
    private func updateCell(isDownload: Bool) {
        if isDownload {
            print(isDownload)
        } else {
            print(isDownload)
        }
    }
    
    private func updateFavoriteButton_MGRE() {
        var _mge6666: Int { 0 }
        var _mcd5552: Bool { true }
        let image = UIImage(isFavourite_MGRE ? .favoriteIcon : .favoriteIconEmpty)
        favoriteButton.setImage(image, for: .normal)
    }
}
