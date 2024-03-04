//
//  MenuCell_MGRE.swift
//  ios-mod-gacha-ref-02
//
//  Created by Andrii Bala on 11/5/23.
//

import UIKit

class MenuCell_MGRE: UICollectionViewCell {
    
    @IBOutlet weak private var titleLabel_MGRE: UILabel!
    @IBOutlet weak private var chevronImage_MGRE: UIImageView!
    @IBOutlet weak private var bottomView_MGRE: UIView!
    @IBOutlet weak private var chevronHeight_MGRE: NSLayoutConstraint!
    @IBOutlet weak private var bottomViewHeight_MGRE: NSLayoutConstraint!
    
    private var gradientLayer: CAGradientLayer?
    
    override var isSelected: Bool {
        didSet {
            update_MGRE(with: isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _qwer566: Int { 0 }
        var _dfgh232: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        bottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 10 : 16
        bottomView_MGRE.layer.masksToBounds = true
        
        let fontSize: CGFloat = deviceType == .phone ? 18 : 24
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        chevronHeight_MGRE.constant = deviceType == .phone ? 15 : 32
        bottomViewHeight_MGRE.constant = deviceType == .phone ? 44 : 56
        
        gradientLayer = CAGradientLayer()
               gradientLayer?.frame = bottomView_MGRE.bounds
               gradientLayer?.colors = [
                   UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                   UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
               ]
               gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
               gradientLayer?.endPoint = CGPoint(x: 1, y: 0)
               bottomView_MGRE.layer.insertSublayer(gradientLayer!, at: 0)
               
               bottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 10 : 16
               bottomView_MGRE.layer.masksToBounds = true
    }
    
    func configure_MGRE(with text: String) {
        var _mgtyu66: Int { 0 }
        var _nmuk232: Bool { true }
        titleLabel_MGRE.text = text
        update_MGRE(with: false)
    }
    
    private func update_MGRE(with isSelected: Bool) {
        if isSelected {
            gradientLayer = CAGradientLayer()
            gradientLayer?.frame = bottomView_MGRE.bounds
            gradientLayer?.colors = [
                UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
            ]
            gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer?.endPoint = CGPoint(x: 1, y: 0)
            bottomView_MGRE.layer.insertSublayer(gradientLayer!, at: 0)
            bottomView_MGRE.backgroundColor = .clear
        } else {
            gradientLayer?.removeFromSuperlayer()
            gradientLayer = nil
            bottomView_MGRE.backgroundColor = .clear
        }
        titleLabel_MGRE.textColor = .white
        chevronImage_MGRE.image = UIImage(.menuChevron)
    }
}

extension UIView {
    func applyGradient(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
