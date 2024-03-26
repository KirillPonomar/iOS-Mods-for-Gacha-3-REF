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
    struct MainStr: Codable {
        let mods: [Main_HIDA]
    }
    private let mods: MainStr

    var list: [Main_HIDA] {
        mods.mods
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case mods
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.mods = try container.decode(MainStr.self, forKey: .mods)
    }
}

struct Main_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .main_hida
    let name: String
    let image: String
    let description: String
    let filePath: String
    let new: Bool
    let top: Bool
    
    var favId: String { id }
    var id: String { image+"Main"}
    var searchText: String? { name }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case name = "wprsbp", image = "8c5ylk", description = "o4a1qowgc",
             new = "new", top = "top", filePath = "7zlbgc"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.description = try container.decode(String.self, forKey: .description)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
        self.filePath = try container.decode(String.self, forKey: .filePath)
    }
    
    init?(from entity: ContentEntity) {
        guard let name = entity.name,
              let image = entity.image,
              let description = entity.descr,
              let filePath = entity.filePath else { return nil }
        self.name = name
        self.image = image
        self.description = description
        self.filePath = filePath
        self.new = entity.new
        self.top = entity.top
    }
}

struct WallpapersListCodable_HIDA: Codable {
    struct WallpapersStr: Codable {
        let Wallpapers: [Wallpaper_HIDA]
    }
    private let wallpapers: WallpapersStr

    var list: [Wallpaper_HIDA] {
        wallpapers.Wallpapers
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case wallpapers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.wallpapers = try container.decode(WallpapersStr.self, forKey: .wallpapers)
    }
}

struct Wallpaper_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .wallpapers_hida
    let image: String
    var new: Bool
    let top: Bool
    
    var favId: String { id }
    var id: String {image+"Wallpaper"}
    var searchText: String? { nil }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case new, top, image = "y6i"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
//        self.id = try container.decode(String.self, forKey: .id)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
        self.image = try container.decode(String.self, forKey: .image)
    }
    
    init?(from entity: ContentEntity) {
        guard let image = entity.image else { return nil }
//        self.id = id
        self.image = image
        self.new = entity.new
        self.top = entity.top
    }
}

struct CharactersResponseCodable_HIDA: Codable {
    struct CharactersStr: Codable {
        let Characters: [Character_HIDA]
    }
    private let сharacters: CharactersStr

    var list: [Character_HIDA] {
        сharacters.Characters
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case list = "outfits"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.сharacters = try container.decode(CharactersStr.self, forKey: .list)
    }
}

struct Character_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .characters_hida
    let name: String
    let image: String
    let new: Bool
    let top: Bool
    
    var favId: String { id }
    var id: String {image+"Character"}
    var searchText: String? { name /*description*/ }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case name = "7lakqeml4", image = "mi-g15mt", new = "new", top = "top"//, description = "dr6sg6t3"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
//        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
//        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init?(from entity: ContentEntity) {
        guard let image = entity.image,
        let name = entity.name else { return nil }
//        self.id = Int(id) ?? 0
        self.name = name
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
    let name: String
    let image: String
//    let description: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var id: String { image+"Outfitidea"}
    var searchText: String? { name /*description*/ }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case name = "cryxdypv", image = "78_zm", new = "new", top = "top"//, description = "eg-t3"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
//        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
//        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init?(from entity: ContentEntity) {
        guard let image = entity.image,
        let name = entity.name else { return nil }
//        self.id = Int(id) ?? 0
        self.name = name
        self.image = image
        self.new = entity.new
        self.top = entity.top
//        self.description = description
    }
}

struct CollectionsListCodable_HIDA: Codable {
    struct MainStr: Codable {
        let Collections: [Collections_HIDA]
    }
    private let mods: MainStr

    var list: [Collections_HIDA] {
        mods.Collections
    }

    enum CodingKeys_HIDA: String, CodingKey {
        case mods
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
        self.mods = try container.decode(MainStr.self, forKey: .mods)
    }
}

struct Collections_HIDA: Codable, ModelProtocol_HIDA {
    static let type: ContentType_HIDA = .collections_hida
    let name: String
    let image: String
//    let description: String
    let new: Bool
    let top: Bool
    
    var favId: String { String(id) }
    var id: String {image+"Wallpaper"}
    var searchText: String? { name /*description*/ }
    
    enum CodingKeys_HIDA: String, CodingKey {
        case name = "ky325vek3e", image = "lxpy9jr0u", new = "new", top = "top"//, description = "9szd4"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys_HIDA.self)
//        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.image = try container.decode(String.self, forKey: .image)
        self.new = try container.decode(Bool.self, forKey: .new)
        self.top = try container.decode(Bool.self, forKey: .top)
//        self.description = try container.decode(String.self, forKey: .description)
    }
    
    init?(from entity: ContentEntity) {
        guard let image = entity.image,
              let name = entity.name/*,
              let description = entity.descr*/ else { return nil }
//        self.id = Int(id) ?? 0
        self.name = name
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
        var _ksdki3: Int { 0 }
        var _afvj3ss: Bool { true }
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
        var _me1d3jm: Int { 0 }
        var _fdwSq2: Bool { true }
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
        var _jcuewh3: Int { 0 }
        var _oi3jcuH: Bool { true }
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
        var _kri48HJ: Int { 0 }
        var _lhxjw12: Bool { true }
        if let cell = cell as? MainCell_HIDA {
            cell.configure_HIDA(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
    
    func configureCell_HIDA(_ cell: UICollectionViewCell, saveFile: ((((Bool) -> Void)?) -> Void)?) {
        var _Ii3dj: String { "84" }
        var _Mjd3i: Bool { true }
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
        var _Vbytn23: Int { 0 }
        var _gbPlF21: Bool { true }
        if let cell = cell as? ContentCell_HIDA {
            cell.configure_HIDA(with: self, isFavorites: isFavorites, update: update, action: action)
        }
    }
}
