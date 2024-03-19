//
//  ContentCodable_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

protocol CellConfigurable_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                           isFavorites: Bool,
                           update: (() -> Void)?,
                           action: (() -> Void)?)
}

protocol ModelProtocol_MGRE: CellConfigurable_MGRE, Codable, Hashable {
    static var type: ContentType_MGRE { get }
    var favId: String { get }
    var searchText: String? { get }
    var new: Bool { get }
    var top: Bool { get }
    var filePath: String? { get }
}

extension ModelProtocol_MGRE {
    var filePath: String? { nil }
}

struct MainResponseCodable_MGRE: Codable {
    struct Mods: Codable {
        let mods: [Main_MGRE]
    }
    private let mods: Mods

    var list: [Main_MGRE] {
        mods.mods
    }

    enum CodingKeys_MGRE: String, CodingKey {
        case mods
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.mods = try container.decode(Mods.self, forKey: .mods)
    }
}

struct Main_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .main_mgre
    let id: String
    let name: String
    let image: String
    let description: String
    let filePath: String
    let new: Bool
    let top: Bool
    
    var favId: String { id }
    var searchText: String? { name }
    
    enum CodingKeys_MGRE: String, CodingKey {
        case id, name = "wprsbp", image = "8c5ylk", description = "o4a1qowgc",
             new = "new", top = "top", filePath = "7zlbgc"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
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

struct WallpapersListCodable_MGRE: Codable {
    struct Wallpapers: Codable {
        let Wallpapers: [Wallpaper_MGRE]
    }
    private let wallpapers: Wallpapers

    var list: [Wallpaper_MGRE] {
        wallpapers.Wallpapers
    }

    enum CodingKeys_MGRE: String, CodingKey {
        case wallpapers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.wallpapers = try container.decode(Wallpapers.self, forKey: .wallpapers)
    }
}

struct Wallpaper_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .wallpapers_mgre
    let id: String = UUID().uuidString
    let image: String
    var new: Bool
    let top: Bool
    
    var favId: String { id }
    var searchText: String? { nil }
    
    enum CodingKeys_MGRE: String, CodingKey {
        case new, top, image = "y6i", id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
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

struct CharactersResponseCodable_MGRE: Codable {
    struct Characters: Codable {
        let Characters: [Character_MGRE]
    }
    private let сharacters: Characters

    var list: [Character_MGRE] {
        сharacters.Characters
    }

    enum CodingKeys_MGRE: String, CodingKey {
        case list = "outfits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.сharacters = try container.decode(Characters.self, forKey: .list)
    }
}

struct Character_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .characters_mgre
    let id: String = UUID().uuidString
    let image: String
    let new: Bool
    let top: Bool
    
    var favId: String { id }
    var searchText: String? { nil /*description*/ }
    
    enum CodingKeys_MGRE: String, CodingKey {
        case id, image = "mi-g15mt", new = "new", top = "top"//, description = "dr6sg6t3"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
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

struct OutfitIdeasListCodable_MGRE: Codable {
    struct OutfitIdeas: Codable {
        let outfitIdeas: [OutfitIdea_MGRE]

        enum CodingKeys_MGRE: String, CodingKey {
            case outfitIdeas = "Outfit ideas"
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
            self.outfitIdeas = try container.decode([OutfitIdea_MGRE].self, forKey: .outfitIdeas)
        }
    }
    private let outfitIdeas: OutfitIdeas

    var list: [OutfitIdea_MGRE] {
        outfitIdeas.outfitIdeas
    }

    enum CodingKeys_MGRE: String, CodingKey {
        case list = "outfits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.outfitIdeas = try container.decode(OutfitIdeas.self, forKey: .list)
    }
}

struct OutfitIdea_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .outfitIdeas_mgre
    let id: String = UUID().uuidString
    let image: String
//    let description: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var searchText: String? { nil /*description*/ }
    
    enum CodingKeys_MGRE: String, CodingKey {
        case id, image = "78_zm", new = "new", top = "top"//, description = "eg-t3"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
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

struct CollectionsListCodable_MGRE: Codable {
    struct Mods: Codable {
        let Collections: [Collections_MGRE]
    }
    private let mods: Mods

    var list: [Collections_MGRE] {
        mods.Collections
    }

    enum CodingKeys_MGRE: String, CodingKey {
        case mods
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
        self.mods = try container.decode(Mods.self, forKey: .mods)
    }
}

struct Collections_MGRE: Codable, ModelProtocol_MGRE {
    static let type: ContentType_MGRE = .collections_mgre
    let id: String = UUID().uuidString
    let image: String
//    let description: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var searchText: String? { nil /*description*/ }
    
    enum CodingKeys_MGRE: String, CodingKey {
        case id, image = "lxpy9jr0u", new = "new", top = "top"//, description = "9szd4"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_MGRE.self)
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

extension Main_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _mge45566: Int { 0 }
        var _mcdfgr22: Bool { true }
        if let cell = cell as? MainCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
}

extension Wallpaper_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _m2344t66: Int { 0 }
        var _mc566r22: Bool { true }
        if let cell = cell as? WallpaperCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update)
        }
    }
}

extension Character_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _mdfgg66: Int { 0 }
        var _m678r22: Bool { true }
        if let cell = cell as? ContentCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }

    func configureCell_MGRE(_ cell: UICollectionViewCell, saveFile: ((((Bool) -> Void)?) -> Void)?) {
        if let cell = cell as? ContentCell_MGRE {
            cell.saveFile = saveFile
        }
    }
}

extension OutfitIdea_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _xcxvt66: Int { 0 }
        var _mc1222: Bool { true }
        if let cell = cell as? MainCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
    
    func configureCell_MGRE(_ cell: UICollectionViewCell, saveFile: ((((Bool) -> Void)?) -> Void)?) {
        if let cell = cell as? MainCell_MGRE {
            cell.saveFile = saveFile
        }
    }
}

extension Collections_MGRE {
    func configureCell_MGRE(_ cell: UICollectionViewCell,
                            isFavorites: Bool,
                            update: (() -> Void)?,
                            action: (() -> Void)?) {
        var _mgvbn66: Int { 0 }
        var _mcsdw22: Bool { true }
        if let cell = cell as? ContentCell_MGRE {
            cell.configure_MGRE(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
}
