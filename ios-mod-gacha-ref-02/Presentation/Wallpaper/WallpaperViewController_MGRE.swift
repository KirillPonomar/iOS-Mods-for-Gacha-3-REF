//
//  WallpaperViewController_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Photos

class WallpaperViewController_MGRE: UIViewController {
    
    enum ModelType_MGRE {
        case wallpapers(Wallpaper_MGRE)
        case collections(Collections_MGRE)
    }
    
    @IBOutlet private weak var navigationView_MGRE: NavigationView_MGRE!
    @IBOutlet private weak var favoriteButton_MGRE: UIButton!
    @IBOutlet private weak var shareButton_MGRE: UIButton!
    @IBOutlet private weak var imageView_MGRE: UIImageView!
    @IBOutlet private weak var previewButton_MGRE: UIButton!
    @IBOutlet private weak var rightIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet private weak var leftIndentConstraint_MGRE: NSLayoutConstraint!
    @IBOutlet var actionButtons_MGRE: [UIButton]!
    @IBOutlet private weak var downloadButton: UIButton!
    @IBOutlet private weak var secondButton: UIButton!
    var modelType_MGRE: ModelType_MGRE?
    var contentType_MGRE: ContentType_MGRE?
    var isFavourite_MGRE: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _MGNqwer2: Int { 0 }
        var _MGfghgxa: Bool { false }
        configureLayout_MGRE()
        configureSubviews_MGRE()
        secondButton.isHidden = true
    }
    
    private func configureLayout_MGRE() {
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
        imageView_MGRE.layer.cornerRadius = 20
    }
    
    func configureSubviews_MGRE() {
        guard let modelType = modelType_MGRE else { return }
        navigationView_MGRE.leftButtonAction_MGRE = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        switch modelType {
        case .wallpapers(let model):
            navigationView_MGRE.build_MGRE(with: "Wallpaper", leftIcon: UIImage(.leftIcon), rightIcon: nil)
            imageView_MGRE.add_MGRE(image: model.image, for: .wallpapers_mgre)
            imageView_MGRE.contentMode = .scaleAspectFill
            contentType_MGRE = .wallpapers_mgre
//            actionButtons[0].isHidden = true
        case .collections(let model):
            navigationView_MGRE.build_MGRE(with: "Collection", leftIcon: UIImage(.leftIcon), rightIcon: nil)
            imageView_MGRE.add_MGRE(image: model.image, for: .wallpapers_mgre)
            imageView_MGRE.contentMode = .scaleAspectFill
            contentType_MGRE = .collections_mgre
        }
        
        updateFavoriteButton_MGRE()
    }
    
    @IBAction func actionButtonDidTap_MGRE(_ sender: UIButton) {
        var _M54wetter2: Int { 0 }
        var _MGqqwwa: Bool { false }
        switch sender.tag {
            
        case 0: favoriteButtonDidTap_MGRE()
        case 1: shareImage_MGRE(image: imageView_MGRE.image, viewController: self)
        case 2: scan_MGRE(image: imageView_MGRE.image)
        case 3: downloadButtonDidTap(downloadButton)
        default: break
        }
    }
    
    private func scan_MGRE(image: UIImage?) {
        var _MGNq161662: Int { 0 }
        var _MGfg1717a: Bool { false }
        guard let image = image else { return }
        let vc = ScanViewController_MGRE.loadFromNib_MGRE()
        vc.image_MGRE = image
        vc.contentType_MGRE = contentType_MGRE
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
    private func updateFavoriteButton_MGRE() {
        var _MGNq1414r2: Int { 0 }
        var _MGf1515xa: Bool { false }
        favoriteButton_MGRE.setImage(isFavourite_MGRE ? .heartIcon : .heartIconEmpty, for: .normal)
        favoriteButton_MGRE.backgroundColor = UIColor.white.withAlphaComponent(0.56)
    }
    
    func favoriteButtonDidTap_MGRE() {
        var _MGN12122: Int { 0 }
        var _MGf1313xa: Bool { false }
        isFavourite_MGRE.toggle()
        updateFavoriteButton_MGRE()
        
        guard let modelType = modelType_MGRE else { return }
        let favId: String
        let contentType: ContentType_MGRE
        switch modelType {
        case .wallpapers(let model):
            favId = model.favId
            contentType = Wallpaper_MGRE.type
        case .collections(let model):
            favId = model.favId
            contentType = Collections_MGRE.type
        }
        
        if isFavourite_MGRE {
            DBManager_MGRE.shared.contentManager.storeFavorites_MGRE(with: favId, contentType: contentType)
        } else {
            DBManager_MGRE.shared.contentManager.deleteFavorites_MGRE(with: favId, contentType: contentType)
        }
    }
    
    @IBAction func downloadButtonDidTap(_ sender: UIButton) {
        var _M3dafsr2: Int { 0 }
        var _M38dsaa: Bool { false }
//        save_MGRE(image: imageView_MGRE.image)
        shareImage_MGRE(image: imageView_MGRE.image, viewController: self)
    }
    
    func save_MGRE(image: UIImage?) {
        var _MGN777r2: Int { 0 }
        var _MGf8888a: Bool { false }
        guard let image = image else { return }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: "No internet connection!"))
            return
        }
        
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status == .authorized { save_MGRE(image: image)
            return
        }
        
        PHPhotoLibrary.requestAuthorization(for: .addOnly, handler: { [weak self] status in
            if status == .authorized { self?.save_MGRE(image: image)
                return
            }
            
            let alertData = AlertData_MGRE(with: "Access to photo library denied!")
            DispatchQueue.main.async {
                self?.showAlert_MGRE(with: alertData)
            }
        })
    }
    
    private func save_MGRE(image: UIImage) {
        var _MGNq5552: Int { 0 }
        var _MGf666a: Bool { false }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved_MGRE(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc
    func imageSaved_MGRE(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        var _MGNq1112: Int { 0 }
        var _MGfg222a: Bool { false }
        if let error = error {
            print("Ошибка сохранения изображения: \(error.localizedDescription)")
        } else {
            let alertData = AlertData_MGRE(with: "Downloaded!")
            showAlert_MGRE(with: alertData)
        }
    }
    
    func shareImage_MGRE(image: UIImage?, viewController: UIViewController) {
        var _MGNq3332: Int { 0 }
        var _MGfg444a: Bool { false }
        guard let image = image else { return }
        guard InternetManager_MGRE.shared.checkInternetConnectivity_MGRE() else {
            showAlert_MGRE(with: AlertData_MGRE(with: "No internet connection!"))
            return
        }
        
        var fileName: String?
        var type: String = ""
        switch modelType_MGRE {
        case .wallpapers(let model):
            type = "Wallpaper"
            fileName = model.image.components(separatedBy: "/").last
        case .collections(let model):
            type = "Collection"
            fileName = model.image.components(separatedBy: "/").last
        default: break
        }
        
        guard let fileName = fileName,
              let fileUrl = saveImageToFile_MGRE(image: image, fileName: fileName) else { return }
        
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
    
    func saveImageToFile_MGRE(image: UIImage, fileName: String) -> URL? {
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
