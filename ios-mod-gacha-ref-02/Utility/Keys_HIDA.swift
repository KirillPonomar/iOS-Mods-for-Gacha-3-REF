//
//  Keys_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import Foundation

struct Keys_HIDA {
    
    enum Path_HIDA: String {
        case editor_hida = "editor",
             main_hida = "mods",
             outfitIdeas_hida = "outfits",
             characters_hida = "characters",
             collections_hida = "collections",
             wallpapers_hida = "wallpapers"
        
        var contentPath: String {
            if self == .editor_hida {
                return .init(format: "/%@/boy/content.json", rawValue, rawValue)
            }
            return .init(format: "/%@/content.json", rawValue, rawValue)
        }
    }
    
    enum App_HIDA: String {
        case accessCode_HIDA = "k_NEn1_GHiMAAAAAAAABkcuYyAiN9X8FSiqoSmCACEU",
             link_HIDA = "https://api.dropboxapi.com/oauth2/token",
             secret_HIDA = "0lr255ygalc63sy",
             key_HIDA = "4elqfm1fdrh1t2k"
    }
}
