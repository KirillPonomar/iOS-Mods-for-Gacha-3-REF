//
//  Alert_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class Alert_MGRE: UIView {
    
    @IBOutlet private weak var titleLabel_MGRE: UILabel!
    @IBOutlet private weak var subtitleLabel_MGRE: UILabel!
    @IBOutlet private weak var buttonContainer_MGRE: UIStackView!
    @IBOutlet private weak var leftButton_MGRE: UIButton!
    @IBOutlet private weak var rightButton_MGRE: UIButton!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var buttonHeight_MGRE: NSLayoutConstraint!
    
    private var action_MGRE: (()->())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var _23555y: Int { 0 }
        var _mcbb2: Bool { true }
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
    }
    
    init() {
        super.init(frame: .zero)
        var _mwetty: Int { 0 }
        var _mefhhe: Bool { true }
        loadViewFromNib_MGRE()
        configureLayout_MGRE()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var _mgxbb: Int { 0 }
        var _mqwerer2: Bool { true }
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    private func configureLayout_MGRE() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rightButton_MGRE.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        rightButton_MGRE.layer.insertSublayer(gradientLayer, at: 0)
        rightButton_MGRE.layer.cornerRadius = 8
        leftButton_MGRE.layer.cornerRadius = 8
        leftButton_MGRE.backgroundColor = .tertiary
    }
    
    func build_MGRE(with data: AlertData_MGRE) {
        leftButton_MGRE.setTitle(data.rightBtnText, for: .normal)
        rightButton_MGRE.setTitle(data.leftBtnText, for: .normal)
        
        buttonContainer_MGRE.isHidden = false
        
        if let title = data.title, !title.isEmpty {
            titleLabel_MGRE.isHidden = false
            titleLabel_MGRE.text = title
        } else {
            titleLabel_MGRE.isHidden = true
        }
        
        if let subtitle = data.subtitle, !subtitle.isEmpty {
            subtitleLabel_MGRE.isHidden = false
            subtitleLabel_MGRE.text = subtitle
        } else {
            subtitleLabel_MGRE.isHidden = true
        }
        
        if data.leftBtnText == nil && data.rightBtnText == nil {
            buttonContainer_MGRE.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.dismissView_MGRE()
            }
        } else if let action = data.action {
            leftButton_MGRE.isHidden = data.leftBtnText.isNilOrEmpty_MGRE
            self.action_MGRE = action
        } else {
            leftButton_MGRE.isHidden = true
        }
    }
    
    private func dismissView_MGRE() {
        var _mgedfg: Int { 0 }
        var _mcbbb2: Bool { true }
        endEditing(true)
        let vc = findViewController_MGRE()
        vc?.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        vc?.dismiss(animated: true)
    }
    
    @IBAction private func leftButtonTapped_MGRE(_ sender: UIButton) {
        var _mgrtt: Int { 0 }
        var _fghhj42: Bool { true }
        dismissView_MGRE()
    }
    
    @IBAction private func rightButtonTapped_MGRE(_ sender: UIButton) {
        var _ecbnyyty: Int { 0 }
        var _swwwe42: Bool { true }
        action_MGRE?()
        dismissView_MGRE()
    }
}

extension UIView_MGRE {
    func findViewController_MGRE() -> UIViewController? {
        var _mdfgy: Int { 0 }
        var _mwert2: Bool { true }
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController_MGRE()
        } else {
            return nil
        }
    }
}
