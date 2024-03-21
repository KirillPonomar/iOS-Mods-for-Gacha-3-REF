//
//  Keys_MGRE.swift
//
//  Created by Kirill Ponomarenko
//

import Foundation

struct Keys_MGRE {
    
    enum Path_MGRE: String {
        case editor_mgre = "editor",
             main_mgre = "mods",
             outfitIdeas_mgre = "outfits",
             characters_mgre = "characters",
             collections_mgre = "collections",
             wallpapers_mgre = "wallpapers"
        
        var contentPath: String {
            if self == .editor_mgre {
                return .init(format: "/%@/girl/content.json", rawValue, rawValue)
            }
            return .init(format: "/%@/content.json", rawValue, rawValue)
        }
    }
    
    enum App_MGRE: String {
        case accessCode_MGRE = "k_NEn1_GHiMAAAAAAAABkcuYyAiN9X8FSiqoSmCACEU",
             link_MGRE = "https://api.dropboxapi.com/oauth2/token",
             secret_MGRE = "0lr255ygalc63sy",
             key_MGRE = "4elqfm1fdrh1t2k"
    }
}
