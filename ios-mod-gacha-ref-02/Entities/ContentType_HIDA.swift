//
//  ContentType_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

enum ContentType_HIDA: Int, CaseIterable {
    case editor_hida = 0,
         main_hida,
         outfitIdeas_hida,
         characters_hida,
         collections_hida,
         wallpapers_hida
    
    var int64_HIDA: Int64 { Int64(rawValue) }
    
    var associatedPath_HIDA: Keys_HIDA.Path_HIDA {
        switch self {
        case .editor_hida:          return .editor_hida
        case .main_hida:            return .main_hida
        case .outfitIdeas_hida:     return .outfitIdeas_hida
        case .characters_hida:      return .characters_hida
        case .collections_hida:     return .collections_hida
        case .wallpapers_hida:      return .wallpapers_hida
        }
    }
    
    var cellClass_HIDA: UICollectionViewCell.Type? {
        switch self {
        case .main_hida:            return MainCell_HIDA.self
        case .outfitIdeas_hida:     return MainCell_HIDA.self
        case .characters_hida:      return ContentCell_HIDA.self
        case .collections_hida:     return ContentCell_HIDA.self
        case .wallpapers_hida:      return WallpaperCell_HIDA.self
        default: return nil
        }
    }
}
