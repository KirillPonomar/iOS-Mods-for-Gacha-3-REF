//
//  Constants_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

enum Images_HIDA: String {
    case menuChevron
    case menuChevronBlack
    
    case menuIcon
    case searchIcon
    case backChevronIcon
    case closeIcon
    case deleteIcon
    case doneIcon
    case leftIcon
    case rightIcon
    
    case favoriteIconEmpty
    case favoriteIcon
    case failureIcon
    case failureIconWhite
    case heartIcon
    case heartIconEmpty
    
    case chevronTopIcon
    case chevronBottomIcon
    case successIcon
    case successIconWhite
    
    case deleteLargeIcon
}

extension UIImage_HIDA {
    convenience init?(_ name: Images_HIDA, in bundle: Bundle = Bundle.main) {
        self.init(named: name.rawValue, in: bundle, compatibleWith: nil)
    }
}
