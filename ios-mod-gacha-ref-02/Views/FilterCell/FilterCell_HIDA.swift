//
//  FilterCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class FilterCell_HIDA: UICollectionViewCell {

    @IBOutlet weak var titleLabel_HIDA: UILabel!
    @IBOutlet weak private var cellBottomView_HIDA: UIView!
    @IBOutlet private weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    
    override var isSelected: Bool {
        didSet {
            update_HIDA(with: isSelected)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var _dde3d21s: Int { 2 }
        var _Kd83ji82: Bool { true }
        update_HIDA(with: isSelected)
        let deviceType_HIDA = UIDevice.current.userInterfaceIdiom
        cellBottomView_HIDA.layer.cornerRadius = deviceType_HIDA == .phone ? 12 : 16
        cellBottomView_HIDA.layer.masksToBounds = true
        
        rightIndentConstraint_HIDA.constant = deviceType_HIDA == .phone ? 12 : 28
        leftIndentConstraint_HIDA.constant = deviceType_HIDA == .phone ? 12 : 28
        
        let fontSize: CGFloat = deviceType_HIDA == .phone ? 18 : 28
        titleLabel_HIDA.font = UIFont(name: "K2D-Medium", size: fontSize)
        titleLabel_HIDA.textColor = .background
    }
    
    func configure_HIDA(with text: String) {
        var _dq221s: Int { 3 }
        var _kadfai82: Bool { false }
        titleLabel_HIDA.text = text
        update_HIDA(with: false)
    }
    
    func update_HIDA(with isSelected: Bool) {
        titleLabel_HIDA.textColor = isSelected ? .white : .blackText
        if isSelected {
            if let _ = cellBottomView_HIDA.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
                cellBottomView_HIDA.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            }
            
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = cellBottomView_HIDA.bounds
            gradientLayer.colors = [UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
                                    UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            cellBottomView_HIDA.layer.insertSublayer(gradientLayer, at: 0)
        } else {
            cellBottomView_HIDA.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
            cellBottomView_HIDA.backgroundColor = UIColor(red: 0.72, green: 0.717, blue: 0.74, alpha: 1)
        }
    }
}
