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
            .init(format: "/%@/content.json", rawValue, rawValue)
//            .init(format: "/%@.json", rawValue, rawValue)
        }
    }
    
    enum App_MGRE: String {
//        case accessCode_MGRE = "czHFetFkAxAAAAAAAAAEa9vA6-b2vQg6uNF-pEhsRBU",
//             link_MGRE = "https://api.dropboxapi.com/oauth2/token",
//             secret_MGRE = "7l84hfluiyz2tlz",
//             key_MGRE = "idlgxb0j79jxx08"
//        
        //        Когда контент загрузят - раскомментить
                case accessCode_MGRE = "k_NEn1_GHiMAAAAAAAABkcuYyAiN9X8FSiqoSmCACEU",
                     link_MGRE = "https://api.dropboxapi.com/oauth2/token",
                     secret_MGRE = "0lr255ygalc63sy",
                     key_MGRE = "4elqfm1fdrh1t2k"
    }
}

//{
//    "access_token": "sl.BxoTsQXvruAgWm1c0IT9Ot5weg03nj3Y2Fq4Wgts2Cklu0hsAOnnSERoTfylcPMMqnp87VSOM9dpM1mqLuYniX8MCzlP1GuEIEuBe3m5tCv1R1ybrvwjoB9Jg9wHtrQEnnJos2D3HA6l45k",
//    "token_type": "bearer",
//    "expires_in": 14400,
//    "refresh_token": "WxC3cShNQagAAAAAAAAAAQOr7J7WsvFyuv_PiEPDqYrPG8hghwLx2g2njldLEzdM",
//    "scope": "account_info.read file_requests.read files.content.read files.metadata.read",
//    "uid": "1067459699",
//    "account_id": "dbid:AAAHKgeXMUYEVCEvEfs2VNSb1KfJ122udrE"
//}%
//kirillponomarenko@MacBook-Pro-Kirill base % curl https://api.dropbox.com/oauth2/token \
//    -d code=k_NEn1_GHiMAAAAAAAABkcuYyAiN9X8FSiqoSmCACEU \
//    -d grant_type=authorization_code \
//    -u "4elqfm1fdrh1t2k:0lr255ygalc63sy"
