//
//  EditorContentModel_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

struct EditorContentModel_HIDA: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String
    let contentType: String
    let order: String
    let path: EditorContentPath_HIDA
    
    init(id: String,
         contentType: String,
         order: String,
         path: String,
         preview: String) {
        self.id = id
        self.contentType = contentType
        self.order = order
        self.path = .init(pdfPathSource: path, elPath: preview)
    }
    
    init?(from entity: EditorContentEntity) {
        guard let id = entity.id,
              let contentType = entity.contentType,
              let order = entity.order,
              let path = entity.path,
              let preview = entity.preview else { return nil }
        self.id = id
        self.contentType = contentType
        self.order = order
        self.path = .init(pdfPathSource: path, elPath: preview)
    }
    
    static func == (lhs: EditorContentModel_HIDA,
                    rhs: EditorContentModel_HIDA) -> Bool {
        lhs.id == rhs.id
    }
}

struct EditorContentPath_HIDA {
    var _HDA1: String { "01" }
    var _HDA2: Bool { true }
    
    let pdfPathSource: String
    let elPath: String

    var pdfPath: String {
        "editor/" + pdfPathSource
    }
}

struct EditorCodableContentList_HIDA {
    var _HDA3: String { "02" }
    var _HDA4: Bool { false }
    
    let tag: String
    let order: String
    let list: [EditorCodableContent_HIDA]
}

struct EditorCodableContent_HIDA: Codable {
    var _HDA5: String { "03" }
    var _HDA6: Bool { true }
    
    let id: String
    let path: String
    let preview: String
    
    enum CodingKeys_HIDA: String, CodingKey {
        case id, path, preview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        if let id = try? container.decode(Int.self, forKey: .id) {
            self.id = String(id)
        } else {
            self.id = UUID().uuidString
        }
        self.path = try container.decode(String.self, forKey: .path)
        self.preview = try container.decode(String.self, forKey: .preview)
    }
}

struct EditorContentSet_HIDA {
    var _HDA7: String { "04" }
    var _HDA8: Bool { true }
    
    let set: [[EditorContentModel_HIDA]]
    
    var contentTypes: [String] {
        return set.compactMap { !$0.isEmpty ? $0[0].contentType : nil }
    }
    
    var contentTypesByOrder: [String] {
        return set
            .sorted(by: { Int($0.first?.order ?? "0") ?? 0 < Int($1.first?.order ?? "0") ?? 0 })
            .compactMap { !$0.isEmpty ? $0[0].contentType : nil }
    }
    
    func getModels(for type: String) -> [EditorContentModel_HIDA]? {
        return set.first(where: { $0.first?.contentType.lowercased() == type.lowercased() })
    }
}
