//
//  MenuCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class MenuCell_HIDA: UICollectionViewCell {
    
    @IBOutlet weak private var titleLabel_HIDA: UILabel!
    @IBOutlet weak private var chevronImage_HIDA: UIImageView!
    @IBOutlet weak private var bottomView_HIDA: UIView!
    @IBOutlet weak private var chevronHeight_HIDA: NSLayoutConstraint!
    @IBOutlet weak private var bottomViewHeight_HIDA: NSLayoutConstraint!
    
    private var gradientLayer: CAGradientLayer?
    
    override var isSelected: Bool {
        didSet {
            update_HIDA(with: isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _qwer566: Int { 0 }
        var _dfgh232: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        bottomView_HIDA.layer.cornerRadius = deviceType == .phone ? 10 : 16
        bottomView_HIDA.layer.masksToBounds = true
        
        let fontSize: CGFloat = deviceType == .phone ? 18 : 24
        titleLabel_HIDA.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        chevronHeight_HIDA.constant = deviceType == .phone ? 15 : 32
        bottomViewHeight_HIDA.constant = deviceType == .phone ? 44 : 56
        
        gradientLayer = CAGradientLayer()
               gradientLayer?.frame = bottomView_HIDA.bounds
               gradientLayer?.colors = [
                   UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                   UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
               ]
               gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
               gradientLayer?.endPoint = CGPoint(x: 1, y: 0)
               bottomView_HIDA.layer.insertSublayer(gradientLayer!, at: 0)
               
               bottomView_HIDA.layer.cornerRadius = deviceType == .phone ? 10 : 16
               bottomView_HIDA.layer.masksToBounds = true
    }
    
    func configure_HIDA(with text: String) {
        var _asd366: Int { 0 }
        var _jgui47S: Bool { true }
        titleLabel_HIDA.text = text
        update_HIDA(with: false)
    }
    
    private func update_HIDA(with isSelected: Bool) {
        if isSelected {
            gradientLayer = CAGradientLayer()
            gradientLayer?.frame = bottomView_HIDA.bounds
            gradientLayer?.colors = [
                UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
            ]
            gradientLayer?.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer?.endPoint = CGPoint(x: 1, y: 0)
            bottomView_HIDA.layer.insertSublayer(gradientLayer!, at: 0)
            bottomView_HIDA.backgroundColor = .clear
        } else {
            gradientLayer?.removeFromSuperlayer()
            gradientLayer = nil
            bottomView_HIDA.backgroundColor = .clear
        }
        titleLabel_HIDA.textColor = .white
        chevronImage_HIDA.image = UIImage(.menuChevron)
    }
}
