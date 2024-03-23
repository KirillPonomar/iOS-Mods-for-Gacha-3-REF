//
//  CharacterEditorImage_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Kingfisher

final class CharacterEditorImage_HIDA: UIView {
    let _Jd83jd: (Int, Int, String) -> Int = { _, _, _ in
        let _Ndu38dv = "_GKdi12"
        let _Kd83nd3 = 10
        for _ in 1...9 {
                return 0
            }
            let _ = (1...4).map { _ in
                return 0
            }
        return 0
    }
    
    var imageViews_HIDA: [(String, UIImageView)] = []
    
    var character_HIDA: CharacterModel_HIDA?
    var preview_HIDA: CharacterPreview_HIDA? { character_HIDA?.preview }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupImageView_HIDA() -> UIImageView {
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.scaleEqualSuperView_HIDA()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func setupCharacter_HIDA(with model: CharacterModel_HIDA, contentSet: EditorContentSet_HIDA, isNew: Bool) {
        self.character_HIDA = model
        contentSet.contentTypesByOrder.forEach { type in
            let imageView = setupImageView_HIDA()
            let models = contentSet.getModels(for: type) ?? []
            if let model = model.content.first(where: { $0.contentType == type }),
               models.contains(where: { $0.id == model.id }) {
                imageView.addPDF_HIDA(image: model.path.pdfPath)
                imageViews_HIDA.append((type, imageView))
            } else if isNew, let model = models.first,
                        model.contentType.lowercased() != "additions" {
                character_HIDA?.change_HIDA(item: model)
                imageView.addPDF_HIDA(image: model.path.pdfPath)
                imageViews_HIDA.append((type, imageView))
            } else {
                imageViews_HIDA.append((type, imageView))
            }
        }
    }
    
    func changeStatus_HIDA(with model: EditorContentModel_HIDA) {
        guard let index = imageViews_HIDA.firstIndex(where: { $0.0 == model.contentType }) else { return }
        let imageView = imageViews_HIDA[index].1
        imageView.addPDF_HIDA(image: model.path.pdfPath)
        
        character_HIDA?.change_HIDA(item: model)
        character_HIDA?.update_HIDA(image: takeScreenshot_HIDA(of: self))
    }
    
    func remove_HIDA(contentType: String) {
        guard let index = imageViews_HIDA.firstIndex(where: { $0.0 == contentType }) else { return }
        let imageView = imageViews_HIDA[index].1
        imageView.image = nil
        
        character_HIDA?.remove_HIDA(contentType)
        character_HIDA?.update_HIDA(image: takeScreenshot_HIDA(of: self))
    }
    
    func updateImage_HIDA() {
        character_HIDA?.update_HIDA(image: takeScreenshot_HIDA(of: self))
    }
    
    func isConfirmationRequired_HIDA(for preview: CharacterPreview_HIDA?) -> Bool {
        guard let current = character_HIDA?.preview else { return false }
        guard let original = preview else { return true }

        let originalSet = original.content.sorted(by: { $0.0 < $1.0 })
        let newSet = current.content.sorted(by: { $0.0 < $1.0 })
        
        for (old, new) in zip(originalSet, newSet) {
            if old.1 != new.1 {
                return false
            }
        }
        
        return true
    }
    
    func getContent_HIDA(for contentType:  String) -> EditorContentModel_HIDA? {
        return character_HIDA?.content.first(where: { $0.contentType == contentType })
    }
    
    private func takeScreenshot_HIDA(of view: UIView) -> UIImage? {
        var _Hio23: Int { 0 }
        var _Ybd21: Bool { false }
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        view.layer.render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}
