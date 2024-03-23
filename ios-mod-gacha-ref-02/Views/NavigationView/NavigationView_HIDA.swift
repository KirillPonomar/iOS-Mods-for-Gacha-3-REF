//
//  NavigationView_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class NavigationView_HIDA: UIView {
    
    @IBOutlet private weak var titleLabel_HIDA: UILabel!
    @IBOutlet private weak var titleView_HIDA: UIView!
    @IBOutlet private weak var leftButton_HIDA: UIButton!
    @IBOutlet private weak var rightButton_HIDA: UIButton!
//    @IBOutlet private weak var undoButton_MGRE: UIButton!
//    @IBOutlet private weak var undoButtonWidth_MGRE: NSLayoutConstraint!
//    @IBOutlet private weak var undoButtonBottomView_MGRE: UIView!
    @IBOutlet private weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftButtonHeight_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var rightButtonHeight_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var titleHeight_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var viewHeight_HIDA: NSLayoutConstraint!
    
    var leftButtonAction_HIDA: (()->())?
    var rightButtonAction_HIDA: (()->())?
    var undoAction_HIDA: (()->())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib_HIDA()
        configureLayout_HIDA()
    }
    
    init() {
        super.init(frame: .zero)
        loadViewFromNib_HIDA()
        configureLayout_HIDA()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let gradient = titleLabel_HIDA.getGradientLayer_HIDA(bounds: .init(origin: .zero, size: titleLabel_HIDA.systemLayoutSizeFitting(.zero)))
        titleLabel_HIDA.textColor = titleLabel_HIDA.gradientColor(bounds: titleLabel_HIDA.bounds, gradientLayer: gradient)
    }
    
    private func configureLayout_HIDA() {
        let deviceType = UIDevice.current.userInterfaceIdiom
        rightIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        leftIndentConstraint_HIDA.constant = deviceType == .phone ? 20 : 85
        viewHeight_HIDA.constant = deviceType == .phone ? 58 : 97
        
        titleHeight_HIDA.constant = deviceType == .phone ? 42 : 52
        leftButtonHeight_HIDA.constant = deviceType == .phone ? 42 : 52
        rightButtonHeight_HIDA.constant = deviceType == .phone ? 42 : 52
        
        let titleFontSize: CGFloat = deviceType == .phone ? 22 : 40
        titleLabel_HIDA.font = UIFont(name: "BakbakOne-Regular", size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
        leftButton_HIDA.layer.cornerRadius = deviceType == .phone ? 21 : 26
        rightButton_HIDA.layer.cornerRadius = deviceType == .phone ? 21 : 26
//        undoButtonBottomView_MGRE.layer.cornerRadius = deviceType == .phone ? 21 : 26
        
//        let fontSize: CGFloat = deviceType == .phone ? 18 : 24
//        let font = UIFont(name: "BakbakOne-Regular", size: fontSize)!
//        undoButton_MGRE.titleLabel?.font = font
//        let width = UILabel.widthForLabel(text: "Reset changes", font: font)
//        undoButtonWidth_MGRE.constant = width
        
//        leftButton_MGRE.addShadow_MGRE(with: UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1))
//        rightButton_MGRE.addShadow_MGRE(with: UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1))
//        undoButtonBottomView_MGRE.addShadow_MGRE(with: UIColor(red: 1, green: 0.702, blue: 0.433, alpha: 1))
        
        titleView_HIDA.customizeView_HIDA(with: deviceType == .phone ? 21 : 26)
//        titleView_MGRE.addShadow_MGRE(with: UIColor(red: 0.887, green: 0.887, blue: 0.887, alpha: 1))
    }
    
    
    func build_HIDA(with title: String,
                    leftIcon: UIImage? = UIImage(.menuIcon),
                    rightIcon: UIImage? = UIImage(.searchIcon), 
                    isEditor: Bool = false) {
        titleLabel_HIDA.text = title
//        titleView_MGRE.isHidden = isEditor ? true : false
        
//        if title.isEmpty {
//            titleView_MGRE.isHidden = true
//        }
        
        if let leftIcon = leftIcon {
            leftButton_HIDA.isHidden = false
            leftButton_HIDA.setImage(leftIcon, for: .normal)
        } else {
            leftButton_HIDA.isHidden = true
        }
        
        if let rightIcon = rightIcon {
            rightButton_HIDA.isHidden = false
            rightButton_HIDA.setImage(rightIcon, for: .normal)
        } else {
            rightButton_HIDA.isHidden = true
        }
    }
    
    @IBAction private func leftButtonTapped_HIDA(_ sender: UIButton) {
        leftButtonAction_HIDA?()
    }
    
    @IBAction private func rightButtonTapped_HIDA(_ sender: UIButton) {
        rightButtonAction_HIDA?()
    }
    
    @IBAction private func undoButtonTapped_HIDA(_ sender: UIButton) {
        undoAction_HIDA?()
    }
}

typealias UIView_HID = UIView

extension UIView_HID {

    func gradientColor(bounds: CGRect, gradientLayer: CAGradientLayer) -> UIColor? {

        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        gradientLayer.render(in: context)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        UIGraphicsEndImageContext()
        return UIColor(patternImage: image)
    }

    func getGradientLayer_HIDA(bounds: CGRect) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1),
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1)
        ].map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        return gradient
    }
}
