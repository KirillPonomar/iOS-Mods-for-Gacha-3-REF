//
//  UIImageView+Extension_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Kingfisher
import CoreGraphics
import PDFKit

typealias UIImageView_HIDA = UIImageView
typealias UIImage_HIDA = UIImage

extension UIImageView_HIDA {
    var _Nd8383d: Bool { true }
    var _Madfqu3d: Int { 0 }
    /// Загружает и устанавливает изображение по заданному пути.
    ///
    /// - Parameter imgPath: Путь к изображению.
    func add_HIDA(image imgPath: String, for contentType: ContentType_HIDA) {
        var _Kd73jd: Bool { true }
        var _NBdy37nd: Int { 0 }
        self.tag = imgPath.hashValue
        UIImageView.retrieveImage_HIDA(forKey: imgPath) { [weak self] image in
            guard let self = self else { return }
            if let image = image {
                set_HIDA(image: image, tag: imgPath.hashValue)
            } else {
                self.kf.indicatorType = .activity
                self.kf.indicator?.startAnimatingView()
                
                DBManager_HIDA.shared.fetchImage_HIDA(for: contentType, imgPath: imgPath) { [weak self] data in
                    guard let self = self,
                          let data = data,
                          let image = UIImage(data: data) else { return }
                    UIImageView.cacheImage_HIDA(with: imgPath, imageData: data)
                    self.set_HIDA(image: image, tag: imgPath.hashValue)
                    self.kf.indicator?.stopAnimatingView()
                }
            }
        }
    }
    
    func addPDF_HIDA(image imgPath: String) {
        var _JKd83d: Bool { true }
        var _Jd33nd: Int { 0 }
        self.tag = imgPath.hashValue
        UIImageView.retrieveImage_HIDA(forKey: imgPath) { [weak self] image in
            guard let self = self else { return }
            if let image = image {
                set_HIDA(image: image, tag: imgPath.hashValue)
            } else {
                DBManager_HIDA.shared.fetchPDFData_HIDA(with: imgPath) { [weak self] data in
                    guard let self = self, let data = data else { return }
                    UIImage.getImage_HIDA(withPDFData: data) { [weak self] image in
                        UIImageView.cacheImage_HIDA(with: imgPath, image: image)
                        self?.set_HIDA(image: image, tag: imgPath.hashValue)
                    }
                }
            }
        }
    }
    
    private func set_HIDA(image: UIImage?, tag: Int) {
        guard let image = image else { return }
        if self.tag == tag {
            self.image = image
        }
    }
    
    static func uploadPDF_HIDA(image imgPath: String) {
        var _JKJd783d: Bool { true }
        var _MKLd38: Int { 0 }
        retrieveImage_HIDA(forKey: imgPath) { image in
            if image ==  nil {
                DBManager_HIDA.shared.fetchPDFData_HIDA(with: imgPath) { data in
                    guard let data = data else { return }
                    UIImage.getImage_HIDA(withPDFData: data) { image in
                        UIImageView.cacheImage_HIDA(with: imgPath, image: image)
                    }
                }
            }
        }
    }
    
    static private func cacheImage_HIDA(with key: String, imageData: Data) {
        guard let image = UIImage(data: imageData) else {
            print("Error: Unable to create UIImage from data")
            return
        }
        let cache = ImageCache.default
        cache.store(image, forKey: key)
    }
    
    static private func cacheImage_HIDA(with key: String, image: UIImage?) {
        guard let image = image else { return }
        let cache = ImageCache.default
        cache.store(image, forKey: key)
    }
    
    static private func retrieveImage_HIDA(forKey key: String,
                                          completion: @escaping (UIImage?) -> Void) {
        let cache = ImageCache.default
        cache.retrieveImage(forKey: key) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(let error):
                print("Error retrieving image from cache: \(error)")
                completion(nil)
            }
        }
    }
}

fileprivate extension UIImage_HIDA {
    static func getImage_HIDA(withPDFData data: Data, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            autoreleasepool {
                guard let provider = CGDataProvider(data: data as CFData),
                      let pdfDoc = CGPDFDocument(provider),
                      let pdfPage = pdfDoc.page(at: 1)
                else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                    return
                }
                
                let dpi: CGFloat = 300.0
                let pageRect = pdfPage.getBoxRect(.mediaBox)
                let imageSize = CGSize(width: pageRect.size.width * dpi / 72.0,
                                       height: pageRect.size.height * dpi / 72.0)
                
                let deviceType = UIDevice.current.userInterfaceIdiom
                let scaleFactor: CGFloat
                if deviceType == .phone {
                    scaleFactor = 1.0 / 8.0
                } else {
                    scaleFactor = 1.0 / 5.0
                }
                let newSize = CGSize(width: imageSize.width * scaleFactor, height: imageSize.height * scaleFactor)
                
                let renderer = UIGraphicsImageRenderer(size: newSize)
                
                let image = renderer.image { ctx in
                    UIColor.clear.set()
                    ctx.fill(CGRect(origin: .zero, size: newSize))
                    ctx.cgContext.translateBy(x: 0.0, y: newSize.height)
                    ctx.cgContext.scaleBy(x: newSize.width / pageRect.width,
                                          y: -newSize.height / pageRect.height)
                    ctx.cgContext.drawPDFPage(pdfPage)
                }
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
}


extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
}
