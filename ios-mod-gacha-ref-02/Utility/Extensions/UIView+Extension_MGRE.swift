//
//  UIView+Extension_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UIView_MGRE = UIView

extension UIView_MGRE {
    func loadViewFromNib_MGRE() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
        view.scaleEqualSuperView_MGRE()
    }
    
    func scaleEqualSuperView_MGRE() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                                     trailingAnchor.constraint(equalTo: superView.trailingAnchor),
                                     topAnchor.constraint(equalTo: superView.topAnchor),
                                     bottomAnchor.constraint(equalTo: superView.bottomAnchor)])
    }
    
    func customizeView_MGRE(with cornerRadius: CGFloat = 12,
                            borderWidth: CGFloat = 0,
                            borderColor: CGColor? = UIColor.white.cgColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        clipsToBounds = true
    }
}

extension UIView_MGRE {
    func addShadow_MGRE(with shadowColor: UIColor,
                        shadowOpacity: Float = 1,
                        shadowRadius: CGFloat = 0,
                        shadowVerticalOffset: CGFloat = 3) {
        
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOffset = CGSize(width: 0, height: shadowVerticalOffset)
        self.clipsToBounds = false
    }
}

extension UIView_MGRE {
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurView, at: 0)
    }
}

extension UIColor {
    func blurredImage(withSize size: CGSize) -> UIImage? {
        guard let filter = CIFilter(name: "CIColorMonochrome") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(CIColor(color: .white), forKey: "inputColor")
        filter.setValue(0.0, forKey: "inputIntensity")
        
        guard let coloredImage = filter.outputImage else {
            return nil
        }
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter?.setValue(coloredImage, forKey: kCIInputImageKey)
        blurFilter?.setValue(5.0, forKey: kCIInputRadiusKey)
        
        guard let blurredImage = blurFilter?.outputImage else {
            return nil
        }
        
        let context = CIContext(options: nil)
        if let cgImage = context.createCGImage(blurredImage, from: CGRect(origin: .zero, size: size)) {
            return UIImage(cgImage: cgImage)
        }
        
        return nil
    }
}
