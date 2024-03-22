//
//  MainCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Kingfisher
import Photos

class MainCell_HIDA: UICollectionViewCell {

    @IBOutlet private weak var titleLabel_HIDA: UILabel!
    @IBOutlet private weak var descriptionLabel_HIDA: UILabel!
    @IBOutlet private weak var imageView_HIDA: UIImageView!
    @IBOutlet private weak var imageViewHeight_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var favoriteButton_HIDA: UIButton!
    @IBOutlet private weak var openButton_HIDA: UIButton!
    
    private(set) var isFavourite_HIDA: Bool = false
    
    private var isOutfit = false
    
    var update_HIDA: (() -> Void)?
    var action_HIDA: (() -> Void)?
    var saveFile: ((((Bool) -> Void)?) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _mgvbn66: Int { 0 }
        var _mcrty22: Bool { true }
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        var _addYUS2: Int { 0 }
        var _kk44k4d: Bool { true }
        self.update_HIDA = nil
        self.action_HIDA = nil
        imageView_HIDA.image = nil
        isFavourite_HIDA = false
        imageView_HIDA.kf.indicator?.stopAnimatingView()
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = openButton_HIDA.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        openButton_HIDA.layer.insertSublayer(gradientLayer, at: 0)
        openButton_HIDA.layer.cornerRadius = 8
        openButton_HIDA.layer.masksToBounds = true
    }
    
    func configure_HIDA(with data: Main_HIDA,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _d33edIU: Int { 0 }
        var _D398id: Bool { true }
        self.update_HIDA = update
        self.action_HIDA = action
        
        self.isFavourite_HIDA = isFavorites
        imageView_HIDA.add_HIDA(image: data.image, for: .main_hida)
        imageView_HIDA.layer.cornerRadius = 20
        titleLabel_HIDA.text = data.name
        titleLabel_HIDA.textColor = .white
        titleLabel_HIDA.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        descriptionLabel_HIDA.text = data.description
        descriptionLabel_HIDA.textColor = .white
        openButton_HIDA.setTitle("Open", for: .normal)
        
        configureCell_HIDA()
    }
    
    func configure_HIDA(with data: OutfitIdea_HIDA,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _das366: Int { 0 }
        var _d2sdj3: Bool { true }
        let buttonWidth: CGFloat = 118
        let originalX = openButton_HIDA.layer.frame.origin.x
        let newOriginX = originalX + openButton_HIDA.layer.frame.size.width - buttonWidth
        self.update_HIDA = update
        self.action_HIDA = action
        self.isFavourite_HIDA = isFavorites
        isOutfit = true
        titleLabel_HIDA.isHidden = true
        descriptionLabel_HIDA.isHidden = true
        imageView_HIDA.add_HIDA(image: data.image, for: .outfitIdeas_hida)
        imageView_HIDA.layer.cornerRadius = 20
        imageView_HIDA.layer.frame.size.height = 182
        openButton_HIDA.setImage(.downloadIcon, for: .normal)
        openButton_HIDA.setTitle("Download", for: .normal)
        openButton_HIDA.configuration?.contentInsets.leading = -5
        openButton_HIDA.configuration?.contentInsets.trailing = -5
        openButton_HIDA.configuration?.imagePadding = 8
        openButton_HIDA.layer.frame = CGRect(x: newOriginX, y: openButton_HIDA.layer.frame.origin.y, width: buttonWidth, height: openButton_HIDA.layer.frame.size.height)
        layer.frame.size.height = 198
        
        configureCell_HIDA()
    }
    
    private func configureCell_HIDA() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        layer.insertSublayer(gradientLayer, at: 0)
        let deviceType = UIDevice.current.userInterfaceIdiom
        let openButtonFontSize: CGFloat = deviceType == .phone ? 16 : 32
        openButton_HIDA.titleLabel?.font = UIFont(name: "BakbakOne-Regular", size: openButtonFontSize) ?? UIFont.systemFont(ofSize: openButtonFontSize)
        openButton_HIDA.setTitleColor(.white, for: .normal)
        
        let titleFontSize: CGFloat = deviceType == .phone ? 22 : 36
        titleLabel_HIDA.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
        
        let descriptionFontSize: CGFloat = deviceType == .phone ? 16 : 32
        descriptionLabel_HIDA.font = UIFont(name: "SF Pro Display Regular", size: descriptionFontSize) ?? UIFont.systemFont(ofSize: descriptionFontSize)
        
        let buttonCornerRadius: CGFloat = deviceType == .phone ? 8 : 12
        openButton_HIDA.layer.cornerRadius = buttonCornerRadius
        favoriteButton_HIDA.layer.cornerRadius = 8
        favoriteButton_HIDA.backgroundColor = .white.withAlphaComponent(0.56)
        imageViewHeight_HIDA.constant = deviceType == .phone ? 182 : 296
        
        updateFavoriteButton_HIDA()
    }
    
    private func updateFavoriteButton_HIDA() {
        var _fjfu3Y: Int { 0 }
        var _sdasd3: Bool { true }
        let image = UIImage(isFavourite_HIDA ? .favoriteIcon : .favoriteIconEmpty)
        favoriteButton_HIDA.setImage(image, for: .normal)
    }
    
    @IBAction func favoriteButtonDidTap_HIDA(_ sender: UIButton) {
        var _mg1116: Int { 0 }
        var _mcd33322: Bool { true }
        isFavourite_HIDA.toggle()
        updateFavoriteButton_HIDA()
        update_HIDA?()
    }
    
    @IBAction func detailButtonDidTap_HIDA(_ sender: UIButton) {
        var _mgfgg566: Int { 0 }
        var _mcdf2232: Bool { true }
        if isOutfit {
            saveFile?({ [weak self] isDownload in
                self?.updateCell(isDownload: isDownload)
            })
        } else {
            action_HIDA?()
        }
    }
    
    private func updateCell(isDownload: Bool) {
        if isDownload {
            let buttonWidth: CGFloat = isDownload ? 135 : 118
            let originalX = openButton_HIDA.layer.frame.origin.x
            let newOriginX = originalX + openButton_HIDA.layer.frame.size.width - buttonWidth
            openButton_HIDA.layer.frame = CGRect(x: newOriginX, y: openButton_HIDA.layer.frame.origin.y, width: buttonWidth, height: openButton_HIDA.layer.frame.size.height)
            openButton_HIDA.setTitle("Downloaded", for: .normal)
            openButton_HIDA.backgroundColor = .systemGreen
            openButton_HIDA.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        } else {
            let buttonWidth: CGFloat = !isDownload ? 165 : 118
            let originalX = openButton_HIDA.layer.frame.origin.x
            let newOriginX = originalX + openButton_HIDA.layer.frame.size.width - buttonWidth
            openButton_HIDA.layer.frame = CGRect(x: newOriginX, y: openButton_HIDA.layer.frame.origin.y, width: buttonWidth, height: openButton_HIDA.layer.frame.size.height)
            openButton_HIDA.setTitle("Download Failed", for: .normal)
            openButton_HIDA.backgroundColor = .systemRed
            openButton_HIDA.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        }
    }
}
