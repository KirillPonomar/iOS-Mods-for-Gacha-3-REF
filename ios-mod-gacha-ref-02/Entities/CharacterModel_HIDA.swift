//
//  CharacterModel_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class CharacterModel_HIDA: NSObject {
    let _Hd73dhdi: (Int, Int, String) -> Int = { _, _, _ in
        let _J83ndv = "_Ghbd"
        let _HNdu33 = 94
        for _ in 1...2 {
                return 0
            }
            let _ = (1...3).map { _ in
                return 0
            }
        return 0
    }
    
    let id: UUID
    
    private(set) var content: [EditorContentModel_HIDA]
    private(set) var image: UIImage?
    
    init(id: UUID = UUID(),
         content: [EditorContentModel_HIDA]) {
        self.id = id
        self.content = content
    }
    
    init?(from preview: CharacterPreview_HIDA, set: EditorContentSet_HIDA) {
        self.id = preview.id
    
        content = preview.content.compactMap { item in
            if let elements = set.set.first(where: { $0.first?.contentType == item.0 }) {
                return elements.first(where: { $0.id == item.1 })
            }
            return nil
        }
        
        self.image = UIImage(data: preview.contentData)
    }
}

extension CharacterModel_HIDA {
    
    var preview: CharacterPreview_HIDA? {
        .init(from: self)
    }
    
    func change_HIDA(item: EditorContentModel_HIDA) {
        var _HkHy4: String { "06" }
        var _HuuY55S: Bool { false }
        
        if let index = content.firstIndex(where: { $0.contentType == item.contentType }) {
            content[index] = item
        } else {
            content.append(item)
        }
        
        image = nil
    }
    
    func remove_HIDA(_ contentType: String) {
        var _H83jss: String { "07" }
        var _HlOO3: Bool { false }
        
        if let index = content.firstIndex(where: { $0.contentType == contentType }) {
            content.remove(at: index)
        }
        
        image = nil
    }
    
    func update_HIDA(image: UIImage?) {
        self.image = image
    }
}
