//
//  FilterCell_MGRE.swift
//  ios-mod-gacha
//
//  Created by Andrii Bala on 10/1/23.
//

import UIKit

class FilterCell_MGRE: UICollectionViewCell {

    @IBOutlet weak var titleLabel_MGRE: UILabel!
    @IBOutlet weak private var cellBottomView_MGRE: UIView!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    private var gradientLayer: CAGradientLayer?
    
    override var isSelected: Bool {
        didSet {
            update_MGRE(with: isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let deviceType = UIDevice.current.userInterfaceIdiom
        cellBottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 12 : 24
        cellBottomView_MGRE.layer.masksToBounds = true
        
        rightIndentConstraint_MGRE.constant = deviceType == .phone ? 12 : 28
        leftIndentConstraint_MGRE.constant = deviceType == .phone ? 12 : 28
        
        let fontSize: CGFloat = deviceType == .phone ? 18 : 28
        titleLabel_MGRE.font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
        titleLabel_MGRE.textColor = .background
    }
    
    func configure_MGRE(with text: String) {
        var _Mwwbbd2: Int { 3 }
        var _bxxxa: Bool { false }
        titleLabel_MGRE.text = text
        update_MGRE(with: false)
    }
    
    func update_MGRE(with isSelected: Bool) {
        titleLabel_MGRE.textColor = isSelected ? .white : .blackText
        if isSelected {
            if let _ = cellBottomView_MGRE.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
                cellBottomView_MGRE.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            }
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = cellBottomView_MGRE.bounds
            gradientLayer.colors = [UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                                    UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            cellBottomView_MGRE.layer.insertSublayer(gradientLayer, at: 0)
        } else {
            cellBottomView_MGRE.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            cellBottomView_MGRE.backgroundColor = UIColor(red: 0.72, green: 0.717, blue: 0.74, alpha: 1)
        }
    }
}
