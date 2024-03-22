//
//  ContentCodable_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

protocol CellConfigurable_HIDA {
    func configureCell_HIDA(_ cell: UICollectionViewCell,
                           isFavorites: Bool,
                           update: (() -> Void)?,
                           action: (() -> Void)?)
}

protocol ModelProtocol_HIDA: CellConfigurable_HIDA, Codable, Hashable {
    static var type: ContentType_HIDA { get }
    var favId: String { get }
    var searchText: String? { get }
    var new: Bool { get }
    var top: Bool { get }
    var filePath: String? { get }
}

extension ModelProtocol_HIDA {
    var filePath: String? { nil }
}

struct MainResponseCodable_HIDA: Codable {
    struct Mods: Codable {
        let mods: [Main_HIDA]
    }
    private let mods: Mods

    var list: [Main_HIDA] {
        mods.mods
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case mods
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.mods = try container.decode(Mods.self, forKey: .mods)
    }
}

struct Main_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .main_hida
    let id: String
    let name: String
    let image: String
    let description: String
    let filePath: String
    let new: Bool
    let top: Bool
    
    var favId: String { id }
    var searchText: String? { name }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case id, name = "wprsbp", image = "8c5ylk", description = "o4a1qowgc",
             new = "new", top = "top", filePath = "7zlbgc"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.id = self.name
        self.image = try container.decode(String.self, forKey: .image)
        self.description = try container.decode(String.self, forKey: .description)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
        self.filePath = try container.decode(String.self, forKey: .filePath)
    }
    
    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let name = entity.name,
              let image = entity.image,
              let description = entity.descr,
              let filePath = entity.filePath else { return nil }
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.filePath = filePath
        self.new = entity.new
        self.top = entity.top
    }
}

struct WallpapersListCodable_HIDA: Codable {
    struct Wallpapers: Codable {
        let Wallpapers: [Wallpaper_HIDA]
    }
    private let wallpapers: Wallpapers

    var list: [Wallpaper_HIDA] {
        wallpapers.Wallpapers
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case wallpapers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.wallpapers = try container.decode(Wallpapers.self, forKey: .wallpapers)
    }
}

struct Wallpaper_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .wallpapers_hida
    let id: String = UUID().uuidString
    let image: String
    var new: Bool
    let top: Bool
    
    var favId: String { id }
    var searchText: String? { nil }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case new, top, image = "y6i", id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
//        self.id = try container.decode(String.self, forKey: .id)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let image = entity.image else { return nil }
//        self.id = id
        self.image = image
        self.new = entity.new
        self.top = entity.top
    }
}

struct CharactersResponseCodable_HIDA: Codable {
    struct Characters: Codable {
        let Characters: [Character_HIDA]
    }
    private let сharacters: Characters

    var list: [Character_HIDA] {
        сharacters.Characters
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case list = "outfits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.сharacters = try container.decode(Characters.self, forKey: .list)
    }
}

struct Character_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .characters_hida
    let id: String = UUID().uuidString
    let image: String
    let new: Bool
    let top: Bool
    
    var favId: String { id }
    var searchText: String? { nil /*description*/ }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case id, image = "mi-g15mt", new = "new", top = "top"//, description = "dr6sg6t3"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
//        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
//        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let image = entity.image else { return nil }
//        self.id = Int(id) ?? 0
        self.image = image
        self.new = entity.new
        self.top = entity.top
//        self.description = description
    }
}

struct OutfitIdeasListCodable_HIDA: Codable {
    struct OutfitIdeas: Codable {
        let outfitIdeas: [OutfitIdea_HIDA]

        enum CodingKeys_HIDA: String, CodingKey {
            case outfitIdeas = "Outfit ideas"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
            self.outfitIdeas = try container.decode([OutfitIdea_HIDA].self, forKey: .outfitIdeas)
        }
    }
    private let outfitIdeas: OutfitIdeas

    var list: [OutfitIdea_HIDA] {
        outfitIdeas.outfitIdeas
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case list = "outfits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.outfitIdeas = try container.decode(OutfitIdeas.self, forKey: .list)
    }
}

struct OutfitIdea_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .outfitIdeas_hida
    let id: String = UUID().uuidString
    let image: String
//    let description: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var searchText: String? { nil /*description*/ }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case id, image = "78_zm", new = "new", top = "top"//, description = "eg-t3"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
//        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
//        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let image = entity.image else { return nil }
//        self.id = Int(id) ?? 0
        self.image = image
        self.new = entity.new
        self.top = entity.top
//        self.description = description
    }
}

struct CollectionsListCodable_HIDA: Codable {
    struct Mods: Codable {
        let Collections: [Collections_HIDA]
    }
    private let mods: Mods

    var list: [Collections_HIDA] {
        mods.Collections
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case mods
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.mods = try container.decode(Mods.self, forKey: .mods)
    }
}

struct Collections_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .collections_hida
    let id: String = UUID().uuidString
    let image: String
//    let description: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var searchText: String? { nil /*description*/ }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case id, image = "lxpy9jr0u", new = "new", top = "top"//, description = "9szd4"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
//        self.id = try container.decode(Int.self, forKey: .id)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
//        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init?(from entity: ContentEntity) {
        guard let id = entity.id,
              let image = entity.image/*,
              let description = entity.descr*/ else { return nil }
//        self.id = Int(id) ?? 0
        self.image = image
        self.new = entity.new
        self.top = entity.top
//        self.description = description
    }
}

extension Main_HIDA {
    func configureCell_HIDA(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _mge45566: Int { 0 }
        var _mcdfgr22: Bool { true }
        if let cell = cell as? MainCell_HIDA {
            cell.configure_HIDA(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
}

extension Wallpaper_HIDA {
    func configureCell_HIDA(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _m2344t66: Int { 0 }
        var _mc566r22: Bool { true }
        if let cell = cell as? WallpaperCell_HIDA {
            cell.configure_HIDA(with: self, isFavorites: isFavorites, update: update)
        }
    }
}

extension Character_HIDA {
    func configureCell_HIDA(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _mdfgg66: Int { 0 }
        var _m678r22: Bool { true }
        if let cell = cell as? ContentCell_HIDA {
            cell.configure_HIDA(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }

    func configureCell_HIDA(_ cell: UICollectionViewCell, saveFile: ((((Bool) -> Void)?) -> Void)?) {
        if let cell = cell as? ContentCell_HIDA {
            cell.saveFile = saveFile
        }
    }
}

extension OutfitIdea_HIDA {
    func configureCell_HIDA(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _xcxvt66: Int { 0 }
        var _mc1222: Bool { true }
        if let cell = cell as? MainCell_HIDA {
            cell.configure_HIDA(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
    
    func configureCell_HIDA(_ cell: UICollectionViewCell, saveFile: ((((Bool) -> Void)?) -> Void)?) {
        if let cell = cell as? MainCell_HIDA {
            cell.saveFile = saveFile
        }
    }
}

extension Collections_HIDA {
    func configureCell_HIDA(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _mgvbn66: Int { 0 }
        var _mcsdw22: Bool { true }
        if let cell = cell as? ContentCell_HIDA {
            cell.configure_HIDA(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
}
