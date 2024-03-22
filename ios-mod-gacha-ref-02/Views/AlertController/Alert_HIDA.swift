//
//  Alert_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class Alert_HIDA: UIView {
    
    let _kjfei888i: (Int, Int, String) -> Int = { _, _, _ in
        let _fn999 = "_Und3j"
        let _nGGG2 = 98
        for _ in 3...6 {
                return 0
            }
            let _ = (7...9).map { _ in
                return 0
            }
        return 0
    }
    
    @IBOutlet private weak var titleLabel_HIDA: UILabel!
    @IBOutlet private weak var subtitleLabel_HIDA: UILabel!
    @IBOutlet private weak var buttonContainer_HIDA: UIStackView!
    @IBOutlet private weak var leftButton_HIDA: UIButton!
    @IBOutlet private weak var rightButton_HIDA: UIButton!
    @IBOutlet private weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var buttonHeight_HIDA: NSLayoutConstraint!
    
    private var action_HIDA: (()->())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        var _Fyec521: Int { 0 }
        var _Ehtnrf232: Bool { true }
        loadViewFromNib_HIDA()
        configureLayout_HIDA()
    }
    
    init() {
        super.init(frame: .zero)
        var _gbCzsd: Int { 0 }
        var _Rjirf2: Bool { true }
        loadViewFromNib_HIDA()
        configureLayout_HIDA()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var _nfj3u: Int { 0 }
        var _A2eder2: Bool { true }
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    private func configureLayout_HIDA() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = rightButton_HIDA.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        rightButton_HIDA.layer.insertSublayer(gradientLayer, at: 0)
        rightButton_HIDA.layer.cornerRadius = 8
        leftButton_HIDA.layer.cornerRadius = 8
        leftButton_HIDA.backgroundColor = .tertiary
    }
    
    func build_HIDA(with data: AlertData_HIDA) {
        leftButton_HIDA.setTitle(data.rightBtnText, for: .normal)
        rightButton_HIDA.setTitle(data.leftBtnText, for: .normal)
        
        buttonContainer_HIDA.isHidden = false
        
        if let title = data.title, !title.isEmpty {
            titleLabel_HIDA.isHidden = false
            titleLabel_HIDA.text = title
        } else {
            titleLabel_HIDA.isHidden = true
        }
        
        if let subtitle = data.subtitle, !subtitle.isEmpty {
            subtitleLabel_HIDA.isHidden = false
            subtitleLabel_HIDA.text = subtitle
        } else {
            subtitleLabel_HIDA.isHidden = true
        }
        
        if data.leftBtnText == nil && data.rightBtnText == nil {
            buttonContainer_HIDA.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
                self?.dismissView_HIDA()
            }
        } else if let action = data.action {
            leftButton_HIDA.isHidden = data.leftBtnText.isNilOrEmpty_HIDA
            self.action_HIDA = action
        } else {
            leftButton_HIDA.isHidden = true
        }
    }
    
    private func dismissView_HIDA() {
        var _Jufy3fg: Int { 0 }
        var _Ljf83d: Bool { true }
        endEditing(true)
        let vc = findViewController_HIDA()
        vc?.view.backgroundColor = UIColor.black.withAlphaComponent(0)
        vc?.dismiss(animated: true)
    }
    
    @IBAction private func leftButtonTapped_HIDA(_ sender: UIButton) {
        var _fcdsftt: Int { 0 }
        var _fu7hgfh42: Bool { true }
        dismissView_HIDA()
    }
    
    @IBAction private func rightButtonTapped_HIDA(_ sender: UIButton) {
        var _Hd8u3nty: Int { 0 }
        var _RfyenB2: Bool { true }
        action_HIDA?()
        dismissView_HIDA()
    }
}

extension UIView_HIDA {
    func findViewController_HIDA() -> UIViewController? {
        var _fwerff4gy: Int { 0 }
        var _mwlk5kd: Bool { true }
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController_HIDA()
        } else {
            return nil
        }
    }
}
