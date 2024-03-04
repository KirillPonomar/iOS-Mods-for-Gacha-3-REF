//
//  ModsCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Andrii Bala on 9/14/23.
//

import UIKit
import Kingfisher

class ModsCell_MGRE: UICollectionViewCell {

    @IBOutlet private weak var titleLabel_MGRE: UILabel!
    @IBOutlet private weak var descriptionLabel_MGRE: UILabel!
    @IBOutlet private weak var imageView_MGRE: UIImageView!
    @IBOutlet private weak var imageViewHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var buttonsHeight_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var favoriteButton_MGRE: UIButton!
    @IBOutlet private weak var openButton_MGRE: UIButton!
    
    private(set) var isFavourite_MGRE: Bool = false
    
    var update_MGRE: (() -> Void)?
    var action_MGRE: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _mgvbn66: Int { 0 }
        var _mcrty22: Bool { true }
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        var _mdfgg566: Int { 0 }
        var _m4677gr22: Bool { true }
        self.update_MGRE = nil
        self.action_MGRE = nil
        imageView_MGRE.image = nil
        isFavourite_MGRE = false
        imageView_MGRE.kf.indicator?.stopAnimatingView()
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = openButton_MGRE.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        openButton_MGRE.layer.insertSublayer(gradientLayer, at: 0)
        openButton_MGRE.layer.cornerRadius = 8
        openButton_MGRE.layer.masksToBounds = true
    }
    
    func configure_MGRE(with data: Mods_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _m45666: Int { 0 }
        var _m12322: Bool { true }
        self.update_MGRE = update
        self.action_MGRE = action
        
        self.isFavourite_MGRE = isFavorites
        imageView_MGRE.add_MGRE(image: data.image, for: .mods_mgre)
        imageView_MGRE.layer.cornerRadius = 20
        titleLabel_MGRE.text = data.name
        titleLabel_MGRE.textColor = .white
        descriptionLabel_MGRE.text = data.description
        descriptionLabel_MGRE.textColor = .white
        
        configureCell_MGRE()
    }
    
    func configure_MGRE(with data: OutfitIdea_MGRE,
                        isFavorites: Bool,
                        update: (() -> Void)?,
                        action: (() -> Void)?) {
        var _m456566: Int { 0 }
        var _m234r22: Bool { true }
        self.update_MGRE = update
        self.action_MGRE = action
        
        self.isFavourite_MGRE = isFavorites
        titleLabel_MGRE.isHidden = true
        descriptionLabel_MGRE.isHidden = true
        imageView_MGRE.add_MGRE(image: data.image, for: .outfitIdeas_mgre)
        imageView_MGRE.layer.cornerRadius = 20
        configureCell_MGRE()
    }
    
    private func configureCell_MGRE() {
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
        let openButtonFontSize: CGFloat = deviceType == .phone ? 18 : 28
        openButton_MGRE.titleLabel?.font = UIFont(name: "BakbakOne-Regular", size: openButtonFontSize) ?? UIFont.systemFont(ofSize: openButtonFontSize)
        openButton_MGRE.setTitleColor(.white, for: .normal)
        
        let titleFontSize: CGFloat = deviceType == .phone ? 20 : 32
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
        
        let descriptionFontSize: CGFloat = deviceType == .phone ? 14 : 22
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: descriptionFontSize) ?? UIFont.systemFont(ofSize: descriptionFontSize)
        
        let buttonCornerRadius: CGFloat = deviceType == .phone ? 8 : 26
        openButton_MGRE.layer.cornerRadius = buttonCornerRadius
        favoriteButton_MGRE.layer.cornerRadius = buttonCornerRadius
        favoriteButton_MGRE.backgroundColor = .white.withAlphaComponent(0.56)
        imageViewHeight_MGRE.constant = deviceType == .phone ? 182 : 190
        
        updateFavoriteButton_MGRE()
    }
    
    private func updateFavoriteButton_MGRE() {
        var _mge6666: Int { 0 }
        var _mcd5552: Bool { true }
        let image = UIImage(isFavourite_MGRE ? .favoriteIcon : .favoriteIconEmpty)
        favoriteButton_MGRE.setImage(image, for: .normal)
    }
    
    @IBAction func favoriteButtonDidTap_MGRE(_ sender: UIButton) {
        var _mg1116: Int { 0 }
        var _mcd33322: Bool { true }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        update_MGRE?()
    }
    
    @IBAction func detailButtonDidTap_MGRE(_ sender: UIButton) {
        var _mgfgg566: Int { 0 }
        var _mcdf2232: Bool { true }
        action_MGRE?()
    }
}
