//
//  UIView+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

typealias UIView_HIDA = UIView

extension UIView_HIDA {
    func loadViewFromNib_HIDA() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        addSubview(view)
        view.scaleEqualSuperView_HIDA()
    }
    
    func scaleEqualSuperView_HIDA() {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([leadingAnchor.constraint(equalTo: superView.leadingAnchor),
                                     trailingAnchor.constraint(equalTo: superView.trailingAnchor),
                                     topAnchor.constraint(equalTo: superView.topAnchor),
                                     bottomAnchor.constraint(equalTo: superView.bottomAnchor)])
    }
    
    func customizeView_HIDA(with cornerRadius: CGFloat = 12,
                            borderWidth: CGFloat = 0,
                            borderColor: CGColor? = UIColor.white.cgColor) {
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor
        clipsToBounds = true
    }
}

extension UIView_HIDA {
    func addShadow_HIDA(with shadowColor: UIColor,
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

extension UIColor_HID {
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
