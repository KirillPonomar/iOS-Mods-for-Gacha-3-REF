//
//  CharacterPreview_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

final class CharacterPreview_HIDA: Hashable {
    var _Ldk3edw: String { "2" }
    var _Mdo39dc: Bool { true }
    let id: UUID
    let contentData: Data
    let content: [String: String]
    
    init(id: UUID,
         contentData: Data,
         content: [String: String]) {
        self.id = id
        self.contentData = contentData
        self.content = content
    }
    
    init?(from model: CharacterModel_HIDA) {
        guard let contentData = model.image?.pngData() else { return nil }
        self.id = model.id
        self.contentData = contentData
        self.content = model.content.reduce(into: [String: String]()) { (result, object) in
            result[object.contentType] = object.id
        }
    }
    
    static func == (lhs: CharacterPreview_HIDA,
                    rhs: CharacterPreview_HIDA) -> Bool {
        lhs.id == rhs.id
    }
    
    init?(from entity: CharacterEntity) {
        guard let id = entity.id,
              let content = entity.content,
              let contentData = entity.contentData else { return nil }
        
        self.id = id
        self.content = content
        self.contentData = contentData
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var image: UIImage? { .init(data: contentData) }
}
