//
//  WallpaperViewController_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Photos

class WallpaperViewController_HIDA: UIViewController {
    
    enum ModelType_HIDA {
        case wallpapers(Wallpaper_HIDA)
        case collections(Collections_HIDA)
    }
    
    @IBOutlet private weak var navigationView_HIDA: NavigationView_HIDA!
    @IBOutlet private weak var favoriteButton_HIDA: UIButton!
    @IBOutlet private weak var shareButton_HIDA: UIButton!
    @IBOutlet private weak var imageView_HIDA: UIImageView!
    @IBOutlet private weak var previewButton_HIDA: UIButton!
    @IBOutlet private weak var rightIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_HIDA: NSLayoutConstraint!
    @IBOutlet var actionButtons_HIDA: [UIButton]!
    @IBOutlet private weak var downloadButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    var modelType_HIDA: ModelType_HIDA?
    var contentType_HIDA: ContentType_HIDA?
    var isFavourite_HIDA: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _jfiei3: Int { 0 }
        var _G73dnd: Bool { false }
        configureLayout_HIDA()
        configureSubviews_HIDA()
        secondButton.isHidden = true
    }
    
    private func configureLayout_HIDA() {
        var _Jsiw: String { "84" }
        var _Jhu3d: Bool { true }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = downloadButton.bounds
        gradientLayer.colors = [
            UIColor(red: 0.37, green: 0.36, blue: 1, alpha: 1).cgColor,
            UIColor(red: 0.96, green: 0.27, blue: 0.95, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        downloadButton.layer.insertSublayer(gradientLayer, at: 0)
        downloadButton.layer.cornerRadius = 16
        downloadButton.layer.masksToBounds = true
        downloadButton.setImage(.downloadIcon, for: .normal)
        downloadButton.semanticContentAttribute = .forceRightToLeft
        downloadButton.setTitle("Download", for: .normal)
        downloadButton.configuration?.imagePadding = 12
        imageView_HIDA.layer.cornerRadius = 20
        shareButton_HIDA.backgroundColor = UIColor.white.withAlphaComponent(0.56)
        previewButton_HIDA.backgroundColor = UIColor.white.withAlphaComponent(0.56)
    }
    
    func configureSubviews_HIDA() {
        var _Hd3kdm: Int { 0 }
        var _I3dmmd: Bool { false }
        guard let modelType = modelType_HIDA else { return }
        navigationView_HIDA.leftButtonAction_HIDA = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        switch modelType {
        case .wallpapers(let model):
            navigationView_HIDA.build_HIDA(with: "Wallpaper", leftIcon: UIImage(.leftIcon), rightIcon: nil)
            imageView_HIDA.add_HIDA(image: model.image, for: .wallpapers_hida)
            imageView_HIDA.contentMode = .scaleAspectFill
            contentType_HIDA = .wallpapers_hida
            //            actionButtons[0].isHidden = true
        case .collections(let model):
            navigationView_HIDA.build_HIDA(with: "Collection", leftIcon: UIImage(.leftIcon), rightIcon: nil)
            imageView_HIDA.add_HIDA(image: model.image, for: .wallpapers_hida)
            imageView_HIDA.contentMode = .scaleAspectFill
            contentType_HIDA = .collections_hida
        }
        
        updateFavoriteButton_HIDA()
    }
    
    @IBAction func actionButtonDidTap_HIDA(_ sender: UIButton) {
        var _djk62jdj: Int { 0 }
        var _K83jdd: Bool { false }
        switch sender.tag {
            
        case 0: favoriteButtonDidTap_HIDA()
        case 1: shareImage_HIDA(image: imageView_HIDA.image, viewController: self)
        case 2: scan_HIDA(image: imageView_HIDA.image)
        case 3: downloadButtonDidTap(downloadButton)
        default: break
        }
    }
    
    private func scan_HIDA(image: UIImage?) {
        var _JKjdi3d: Int { 0 }
        var _MK3ddd: Bool { false }
        guard let image = image else { return }
        let vc = ScanViewController_HIDA.loadFromNib_HIDA()
        vc.image_HIDA = image
        vc.contentType_HIDA = contentType_HIDA
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
    private func updateFavoriteButton_HIDA() {
        var _Mldj3JHJ: Int { 0 }
        var _Hdu3hdd: Bool { false }
        favoriteButton_HIDA.setImage(isFavourite_HIDA ? .heartIcon : .heartIconEmpty, for: .normal)
        favoriteButton_HIDA.backgroundColor = UIColor.white.withAlphaComponent(0.56)
    }
    
    func favoriteButtonDidTap_HIDA() {
        var _d3dsdaa: Int { 0 }
        var _Lud83hjd: Bool { false }
        isFavourite_HIDA.toggle()
        updateFavoriteButton_HIDA()
        
        guard let modelType = modelType_HIDA else { return }
        let favId: String
        let contentType: ContentType_HIDA
        switch modelType {
        case .wallpapers(let model):
            favId = model.favId
            contentType = Wallpaper_HIDA.type
        case .collections(let model):
            favId = model.favId
            contentType = Collections_HIDA.type
        }
        
        if isFavourite_HIDA {
            DBManager_HIDA.shared.contentManager.storeFavorites_HIDA(with: favId, contentType: contentType)
        } else {
            DBManager_HIDA.shared.contentManager.deleteFavorites_HIDA(with: favId, contentType: contentType)
        }
    }
    
    @IBAction func downloadButtonDidTap(_ sender: UIButton) {
        var _Jdu34dd: Int { 0 }
        var _Kdi48dd: Bool { false }
        //        save_HIDA(image: imageView_HIDA.image)
        shareImage_HIDA(image: imageView_HIDA.image, viewController: self)
    }
    
    func save_HIDA(image: UIImage?) {
        var _Kdj3jd: Int { 0 }
        var _Gbljhfc23: Bool { false }
        guard let image = image else { return }
        guard InternetManager_HIDA.shared.checkInternetConnectivity_HIDA() else {
            showAlert_HIDA(with: AlertData_HIDA(with: "No internet connection!"))
            return
        }
        
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status == .authorized { save_HIDA(image: image)
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly, handler: { [weak self] status in
            if status == .authorized { self?.save_HIDA(image: image)
                return
            }
            
            let alertData = AlertData_HIDA(with: "Access to photo library denied!")
            DispatchQueue.main.async {
                self?.showAlert_HIDA(with: alertData)
            }
        })
    }
    
    private func save_HIDA(image: UIImage) {
        var _hHry2ss: Int { 0 }
        var _Jdu3uyd87: Bool { false }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved_HIDA(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func imageSaved_HIDA(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _Inmu3jd: Int { 0 }
        var _lY4dnia: Bool { false }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            let alertData = AlertData_HIDA(with: "Downloaded!")
            showAlert_HIDA(with: alertData)
        }
    }
    
    func shareImage_HIDA(image: UIImage?, viewController: UIViewController) {
        var _Ud83hjd: Int { 0 }
        var _Ju3dja: Bool { false }
        guard let image = image else { return }
        guard InternetManager_HIDA.shared.checkInternetConnectivity_HIDA() else {
            showAlert_HIDA(with: AlertData_HIDA(with: "No internet connection!"))
            return
        }
        
        var fileName: String?
        var type: String = ""
        switch modelType_HIDA {
        case .wallpapers(let model):
            type = "Wallpaper"
            fileName = model.image.components(separatedBy: "/").last
        case .collections(let model):
            type = "Collection"
            fileName = model.image.components(separatedBy: "/").last
        default: break
        }
        
        guard let fileName = fileName,
              let fileUrl = saveImageToFile_HIDA(image: image, fileName: fileName) else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
        activityViewController.title = "Download \(type)"
        activityViewController.completionWithItemsHandler = { [weak self] (activityType, completed, returnedItems, error) in
            if completed {
                self?.secondButton.isHidden = false
                self?.secondButton.setTitle("Downloaded", for: .normal)
                self?.secondButton.semanticContentAttribute = .forceRightToLeft
                self?.secondButton.setImage(.successIcon, for: .normal)
                self?.secondButton.setTitleColor(.systemGreen, for: .normal)
                self?.secondButton.configuration?.imagePadding = 12
                self?.secondButton.layer.masksToBounds = true
            } else {
                print("Действие отменено")
                self?.secondButton.isHidden = false
                self?.secondButton.setTitle("Download Failed", for: .normal)
                self?.secondButton.semanticContentAttribute = .forceRightToLeft
                self?.secondButton.setImage(.failureIcon, for: .normal)
                self?.secondButton.setTitleColor(.systemRed, for: .normal)
                self?.secondButton.configuration?.imagePadding = 12
                self?.secondButton.layer.masksToBounds = true
            }
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityViewController.modalPresentationStyle = .popover
            
            if let popoverPresentationController = activityViewController.popoverPresentationController {
                popoverPresentationController.sourceView = viewController.view
                popoverPresentationController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
                popoverPresentationController.permittedArrowDirections = []
            }
        }
        
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
    func saveImageToFile_HIDA(image: UIImage, fileName: String) -> URL? {
        var _Jdsadj: String { "22" }
        var _J3dsaa: Bool { true }
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Documents directory not found.")
            return nil
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else {
            print("Failed to get JPEG representation of UIImage.")
            return nil
        }
        
        do {
            try data.write(to: fileURL)
            print("File saved: \(fileURL)")
            return fileURL
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
}
