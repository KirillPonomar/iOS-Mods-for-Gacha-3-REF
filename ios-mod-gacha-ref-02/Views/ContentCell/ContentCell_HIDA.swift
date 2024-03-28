//
//  ContentCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Kingfisher
import Photos

class ContentCell_HIDA: UICollectionViewCell {

    @IBOutlet private weak var imageView_HIDA: UIImageView!
    @IBOutlet private weak var downloadButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    private(set) var isFavourite_HIDA: Bool = false
    
    var update_HIDA: (() -> Void)?
    var action_HIDA: (() -> Void)?
    var saveFile: ((((Bool) -> Void)?) -> Void)?
    private var isCharacter = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _jdu8238: Int { 0 }
        var _hYd73d: Bool { true }
        layer.cornerRadius = 16
        layer.masksToBounds = true
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.setTitleColor(.white, for: .normal)
        downloadButton.layer.cornerRadius = 8
        favoriteButton.layer.cornerRadius = 8
        downloadButton.layer.borderWidth = 0.8
        downloadButton.layer.borderColor = UIColor.white.cgColor
    }

    override func prepareForReuse() {
        var _HfcIbaheq3: Int { 0 }
        var _EdblBim472: Bool { true }
        self.action_HIDA = nil
        imageView_HIDA.image = nil
        imageView_HIDA.kf.indicator?.stopAnimatingView()
    }
    
    func configure_HIDA(with data: Collections_HIDA,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _xNj38: Int { 0 }
        var _Ns2ed: Bool { true }
        self.isFavourite_HIDA = isFavorites
        self.update_HIDA = update
        self.action_HIDA = action
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = layer.bounds
        gradientLayer.colors = [UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                                UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
        
//        imageView_HIDA.contentMode = .scaleAspectFill
        imageView_HIDA.layer.cornerRadius = 12
        favoriteButton.layer.cornerRadius = 8
        favoriteButton.backgroundColor = .white.withAlphaComponent(0.56)
        downloadButton.setTitle("Open", for: .normal)
        imageView_HIDA.add_HIDA(image: data.image, for: .collections_hida)
        
        updateFavoriteButton_HIDA()
    }
    
    func configure_HIDA(with data: Character_HIDA,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _Ljk: Int { 0 }
        var _Rfte1: Bool { true }
        self.isFavourite_HIDA = isFavorites
        self.update_HIDA = update
        self.action_HIDA = action
        isCharacter = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = layer.bounds
        gradientLayer.colors = [UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                                UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        layer.insertSublayer(gradientLayer, at: 0)
        
        imageView_HIDA.layer.cornerRadius = 12
        favoriteButton.layer.cornerRadius = 8
        favoriteButton.backgroundColor = .white.withAlphaComponent(0.56)
        downloadButton.setImage(.downloadIcon, for: .normal)
        downloadButton.configuration?.imagePadding = 8
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.backgroundColor = .clear
        imageView_HIDA.add_HIDA(image: data.image, for: .characters_hida)
        updateFavoriteButton_HIDA()
    }
    
    @IBAction func favoriteButtonDidTap_HIDA(_ sender: UIButton) {
        var _mdfdsfds6: Int { 0 }
        var _e32df22: Bool { true }
        isFavourite_HIDA.toggle()
        updateFavoriteButton_HIDA()
        update_HIDA?()
    }
    
    @IBAction func detailButtonDidTap_HIDA(_ sender: UIButton) {
        var _Hy7d7366: Int { 0 }
        var _A89bds: Bool { true }
        if isCharacter {
            saveFile?({ [weak self] isDownload in
                self?.updateCell_HIDA(isDownload: isDownload)})
        } else {
            action_HIDA?()
        }
    }
    
    private func updateCell_HIDA(isDownload: Bool) {
        if !isCharacter {
            if isDownload {
                downloadButton.setTitle("Downloaded", for: .normal)
                downloadButton.backgroundColor = .systemGreen
                downloadButton.layer.borderColor = UIColor(.clear).cgColor
            } else {
                downloadButton.setTitle("Download Failed", for: .normal)
                downloadButton.backgroundColor = .systemRed
                downloadButton.layer.borderColor = UIColor(.clear).cgColor
            }
        } else {
            if isDownload {
                downloadButton.setTitle("Downloaded", for: .normal)
                downloadButton.backgroundColor = .systemGreen
                downloadButton.setImage(.successIconWhite, for: .normal)
                downloadButton.configuration?.imagePadding = 8
                downloadButton.configuration?.contentInsets.leading = -5
                downloadButton.configuration?.contentInsets.trailing = -5
                downloadButton.layer.borderColor = UIColor(.clear).cgColor
            } else {
                downloadButton.setTitle("Failed", for: .normal)
                downloadButton.backgroundColor = .systemRed
                downloadButton.setImage(.failureIconWhite, for: .normal)
                downloadButton.configuration?.imagePadding = 8
                downloadButton.layer.borderColor = UIColor(.clear).cgColor
            }
        }
    }
    
    private func updateFavoriteButton_HIDA() {
        var _hfyr333: Int { 0 }
        var _ffkfk48: Bool { true }
        let image = UIImage(isFavourite_HIDA ? .favoriteIcon : .favoriteIconEmpty)
        favoriteButton.setImage(image, for: .normal)
    }
}
