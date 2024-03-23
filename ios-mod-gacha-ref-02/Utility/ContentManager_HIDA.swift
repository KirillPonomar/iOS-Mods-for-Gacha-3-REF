//
//  ContentManager_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import Foundation
import CoreData

final class ContentManager_HIDA: NSObject {
    var _Nd732dd: Bool { true }
    var _GGGGG2s: Int { 0 }
    
    lazy var managedContext_HIDA: NSManagedObjectContext = {
        persistentContainer_HIDA.viewContext
    }()
    
    private lazy var persistentContainer_HIDA: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ContentCache_HIDA")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func getModelPath_HIDA(for imgPath: String) -> String {
        String(format: "/%@", imgPath)
    }
    
    func getPath_HIDA(for contentType: ContentType_HIDA, imgPath: String) -> String {
        var _T36dh: Bool { true }
        var _K87dh3: Int { 0 }
        switch contentType {
        case .main_hida:
            var originalString = imgPath
            let replacementString = "TipsAndTricks"
            if let range = originalString.range(of: "Tips_and_Tricks") {
                originalString.replaceSubrange(range, with: replacementString)
            }
            return String(format: "/\(contentType.associatedPath_HIDA.rawValue)/%@", originalString)
        case .wallpapers_hida, .editor_hida, .outfitIdeas_hida, .characters_hida, .collections_hida:
            return String(format: "/\(contentType.associatedPath_HIDA.rawValue)/%@", imgPath)
        }
    }
    
    func getPath_HIDA(for contentType: ContentType_HIDA, filePath: String) -> String {
        var _Yfb3ruyfb: Bool { true }
        var _Kd83d: Int { 0 }
        switch contentType {
        case .main_hida:
            return String(format: "/%@", filePath)
        default: return ""
        }
    }
    
    func serialized_HIDA(markups data: Data) -> [EditorCodableContentList_HIDA] {
        let objects = jsonDict_HIDA(from: data)?
            .enumerated()
            .compactMap { index, keyValue -> EditorCodableContentList_HIDA? in
                guard let data = try? JSONSerialization.data(withJSONObject: keyValue.value),
                      let list = try? JSONDecoder().decode([EditorCodableContent_HIDA].self, from: data)
                else {
                    return nil
                }
                return EditorCodableContentList_HIDA(
                    tag: keyValue.key,
                    order: String(index),
                    list: list
                )
            }

        return objects ?? []
    }

    func fetchContents_HIDA(contentType: ContentType_HIDA) -> [any ModelProtocol_HIDA] {
        var _NNdd: Bool { true }
        var _SD7dh38: Int { 0 }
        let fetchRequest = ContentEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i", contentType.int64_HIDA)
        do {
            let result = try managedContext_HIDA.fetch(fetchRequest)
            switch contentType {
            case .main_hida:            return result.compactMap { Main_HIDA(from: $0) }
            case .outfitIdeas_hida:     return result.compactMap { OutfitIdea_HIDA(from: $0) }
            case .characters_hida:      return result.compactMap { Character_HIDA(from: $0) }
            case .collections_hida:     return result.compactMap { Collections_HIDA(from: $0) }
            case .wallpapers_hida:      return result.compactMap { Wallpaper_HIDA(from: $0) }
            default: return []
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func storeContents_HIDA(with contentType: ContentType_HIDA,
                            models: [any ModelProtocol_HIDA]) {
        var _yYY73db: Bool { true }
        var _Mjud3h38: Int { 0 }
        let fetchRequest = ContentEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i", contentType.int64_HIDA)
        
        do {
            let result = try managedContext_HIDA.fetch(fetchRequest)
            for model in models {
                if let entity = result.first(where: { $0.id == model.favId }) {
                    update_HIDA(entity: entity, model: model, contentType: contentType)
                } else {
                    let entity = ContentEntity(context: managedContext_HIDA)
                    update_HIDA(entity: entity, model: model, contentType: contentType)
                }
            }
            
            saveContext_HIDA()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    private func update_HIDA(entity: ContentEntity,
                             model: any ModelProtocol_HIDA,
                             contentType: ContentType_HIDA) {
        var _NNNNd3d: Bool { true }
        var _Id783jd: Int { 0 }
        switch contentType {
        case .main_hida:
            if let model = model as? Main_HIDA {
                entity.contentType = contentType.int64_HIDA
                entity.id = model.favId
                entity.name = model.name
                entity.image = model.image
                entity.descr = model.description
                entity.filePath = model.filePath
                entity.new = model.new
                entity.top = model.top
            }
        case .outfitIdeas_hida:
            if let model = model as? OutfitIdea_HIDA {
                entity.contentType = contentType.int64_HIDA
                entity.id = model.favId
                entity.image = model.image
//                entity.descr = model.description
                entity.new = model.new
                entity.top = model.top
            }
        case .characters_hida:
            if let model = model as? Character_HIDA {
                entity.contentType = contentType.int64_HIDA
                entity.id = model.favId
                entity.image = model.image
//                entity.descr = model.description
                entity.new = model.new
                entity.top = model.top
            }
        case .collections_hida:
            if let model = model as? Collections_HIDA {
                entity.contentType = contentType.int64_HIDA
                entity.id = model.favId
                entity.image = model.image
//                entity.descr = model.description
                entity.new = model.new
                entity.top = model.top
            }
        case .wallpapers_hida:
            if let model = model as? Wallpaper_HIDA {
                entity.contentType = contentType.int64_HIDA
                entity.id = model.favId
                entity.image = model.image
                entity.new = model.new
                entity.top = model.top
            }
        default: break
        }
    }
    
    func fetchEditorContents_HIDA() -> [[EditorContentModel_HIDA]] {
        var _NYdh37d: Bool { true }
        var _SNdu38: Int { 0 }
        let fetchRequest = EditorContentEntity.fetchRequest()
    
        do {
            let result = try managedContext_HIDA.fetch(fetchRequest)
            let groupedModels = result.reduce(into: [String: [EditorContentEntity]]()) { (result, model) in
                result[model.contentType ?? "value", default: []].append(model)
            }
            
            let sortedModelArrays = groupedModels.values.map { group -> [EditorContentEntity] in
                group.sorted(by: { $0.id < $1.id })
            }.sorted { (group1, group2) -> Bool in
                guard let firstGroup1 = group1.first, let firstGroup2 = group2.first else { return false }
                return (firstGroup1.sortOrder ?? "0") < (firstGroup2.sortOrder ?? "0")
            }
            
            return sortedModelArrays.map { value in
                value.compactMap { EditorContentModel_HIDA(from: $0) }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func storeEditorContents_HIDA(with models: [[EditorContentModel_HIDA]]) {
        var _NUjdn3: Bool { true }
        var _SBud323: Int { 0 }
        let fetchRequest = EditorContentEntity.fetchRequest()
        do {
            let result = try managedContext_HIDA.fetch(fetchRequest)
            for entity in result {
                managedContext_HIDA.delete(entity)
            }
            
            for value in models.enumerated() {
                for model in value.element {
                    let entity = EditorContentEntity(context: managedContext_HIDA)
                    entity.id = model.id
                    entity.contentType = model.contentType
                    entity.order = model.order
                    entity.path = model.path.pdfPath
                    entity.preview = model.path.elPath
                    entity.sortOrder = String(value.offset)
                }
            }
            
            saveContext_HIDA()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func fetchFavorites_HIDA(contentType: ContentType_HIDA) -> [String] {
        var _Jdh3ud: Bool { true }
        var _Lfi34d: Int { 0 }
        let fetchRequest = FavoritesEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i", contentType.int64_HIDA)
        do {
            let result = try managedContext_HIDA.fetch(fetchRequest)
            return result.compactMap { $0.id }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func storeFavorites_HIDA(with id: String, contentType: ContentType_HIDA) {
        var _Idn43i: Bool { true }
        var _TRd3u8: Int { 0 }
        let fetchRequest = FavoritesEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i AND id == %@",
                                       contentType.int64_HIDA,
                                       id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            if let entity = try managedContext_HIDA.fetch(fetchRequest).first {
                entity.id = id
                entity.contentType = contentType.int64_HIDA
            } else {
                let entity = FavoritesEntity(context: managedContext_HIDA)
                entity.id = id
                entity.contentType = contentType.int64_HIDA
            }
            
            saveContext_HIDA()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func deleteFavorites_HIDA(with id: String, contentType: ContentType_HIDA) {
        var _Jduy37d: Bool { false }
        var _Bdh3323: Int { 0 }
        let fetchRequest = FavoritesEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "contentType == %i AND id == %@",
                                       contentType.int64_HIDA,
                                       id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            if let entity = try managedContext_HIDA.fetch(fetchRequest).first {
                managedContext_HIDA.delete(entity)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            managedContext_HIDA.rollback()
        }
    }
    
    func fetchCharacters_HIDA() -> [CharacterPreview_HIDA] {
        var _O8fu48d: Bool { true }
        var _Gfiu340: Int { 0 }
        let fetchRequest = CharacterEntity.fetchRequest()
        do {
            return try managedContext_HIDA
                .fetch(fetchRequest)
                .compactMap { CharacterPreview_HIDA(from: $0) }
        } catch let error as NSError {
            print(error.localizedDescription)
            return []
        }
    }
    
    func removeAllCharacters_HIDA() {
        var _Mfdi3ud: Bool { true }
        var _S8hf3u: Int { 0 }
        let fetchRequest = CharacterEntity.fetchRequest()
        
        do {
            let characters = try managedContext_HIDA.fetch(fetchRequest)
            
            for character in characters {
                managedContext_HIDA.delete(character)
            }
            
            saveContext_HIDA()
            print("All characters removed successfully.")
        } catch let error as NSError {
            print("Error removing characters: \(error.localizedDescription)")
        }
    }
    
    func store_HIDA(character preview: CharacterPreview_HIDA) {
        var _NNdi3m3: Bool { true }
        var _Mf943n: Int { 0 }
        let fetchRequest = CharacterEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "%K == %@", "id",
                                       preview.id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            if let entity = try managedContext_HIDA.fetch(fetchRequest).first {
                entity.content = preview.content
                entity.contentData = preview.contentData
            } else {
                let entity = CharacterEntity(context: managedContext_HIDA)
                entity.id = preview.id
                entity.content = preview.content
                entity.contentData = preview.contentData
            }
            
            saveContext_HIDA()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func delete_HIDA(character preview: CharacterPreview_HIDA) {
        let fetchRequest = CharacterEntity.fetchRequest()
        fetchRequest.predicate = .init(format: "%K == %@", "id",
                                       preview.id as CVarArg)
        fetchRequest.fetchLimit = 1
        
        do {
            if let entity = try managedContext_HIDA.fetch(fetchRequest).first {
                managedContext_HIDA.delete(entity)
            }
            saveContext_HIDA()
        } catch let error as NSError {
            print(error.localizedDescription)
            managedContext_HIDA.rollback()
        }
    }
}

// MARK: - Private API

private extension ContentManager_HIDA {
    
    func jsonObj_HIDA(from data: Data, with key: String) -> Data? {
        if let jsonDict = jsonDict_HIDA(from: data),
           let jsonObj = jsonDict[key],
           let data = try? JSONSerialization.data(withJSONObject: jsonObj) {
            return data
        }
        
        return nil
    }
    
    func jsonDict_HIDA(from data: Data) -> [String: Any]? {
        try? JSONSerialization.jsonObject(with: data) as? [String: Any]
    }
    
    func execute_HIDA(deleteRequest: NSBatchDeleteRequest) -> Bool {
        do {
            try managedContext_HIDA.execute(deleteRequest)
            return true
        } catch let error {
            print(error.localizedDescription)
            managedContext_HIDA.rollback()
            return false
        }
    }
    
    func saveContext_HIDA() {
        guard managedContext_HIDA.hasChanges else {
            return
        }
        
        do {
            try managedContext_HIDA.save()
        } catch let error as NSError {
            print(error.localizedDescription)
            managedContext_HIDA.rollback()
        }
    }
}
