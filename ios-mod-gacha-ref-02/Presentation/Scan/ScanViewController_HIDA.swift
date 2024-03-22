//
//  ScanViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class ScanViewController_HIDA: UIViewController {

    @IBOutlet private weak var imageView_HIDA: UIImageView!
    @IBOutlet private weak var stackView_HIDA: UIStackView!
    @IBOutlet private weak var icon4_HIDA: UIImageView!
    @IBOutlet private weak var icon5_HIDA: UIImageView!
    @IBOutlet private weak var icon6_HIDA: UIImageView!
    
    var image_HIDA: UIImage?
    var contentType_HIDA: ContentType_HIDA?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _Yn2tcn2s: Int { 0 }
        var _Ntr89cn3Gj: Bool { true }
        imageView_HIDA.image = image_HIDA
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap_HIDA))
        self.view.addGestureRecognizer(tapGesture)
        
        configureLayout_HIDA()
        configureSubviews_HIDA()
    }
    
    func configureSubviews_HIDA() {
        var _Rf2rLt2s: Int { 0 }
        var _Yjhv7FE: Bool { true }
        guard let contentType = contentType_HIDA else { return }
        switch contentType {
        case .wallpapers_hida:       imageView_HIDA.contentMode = .scaleAspectFill
        case .collections_hida:      imageView_HIDA.contentMode = .scaleAspectFill
        default: break
        }
    }
    
    func configureLayout_HIDA() {
        var _NjYjhv6: Int { 0 }
        var _Gjy5Ghb8: Bool { true }
        let deviceType = UIDevice.current.userInterfaceIdiom
        stackView_HIDA.distribution = deviceType == .phone ? .equalSpacing : .fill
        icon4_HIDA.isHidden = deviceType == .phone ? true : false
        icon5_HIDA.isHidden = deviceType == .phone ? true : false
        icon6_HIDA.isHidden = deviceType == .phone ? true : false
    }
    
    @objc
    func handleTap_HIDA(_ sender: UITapGestureRecognizer) {
        var _Gnf2dd2: Int { 0 }
        var _Rnj567n: Bool { false }
        
        dismiss(animated: true)
    }
}
