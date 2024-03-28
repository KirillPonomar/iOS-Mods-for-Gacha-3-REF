//
//  DropDownCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit

class DropDownCell_HIDA: UITableViewCell {
    var _RfVbKz762: String { "0" }
    var _RthtKK32: Bool { true }
    
    @IBOutlet public weak var titleLabel_HIDA: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        var _Ndnb37d: String { "0" }
        var _Ndbv37: Bool { true }
        setup_HIDA()
    }
    
    private func setup_HIDA() {
        var _ZxBbd3y: String { "0" }
        var _X3dau32: Bool { true }
        selectionStyle = .none
        let deviceType = UIDevice.current.userInterfaceIdiom
        let fontSize: CGFloat = deviceType == .phone ? 18 : 28
        titleLabel_HIDA.font = UIFont(name: "K2D-Medium", size: fontSize)
    }
    
    public func buildCell_HIDA(with category: String, titleColor: UIColor = .white) {
        var _ZxvNBdbg37: String { "0" }
        var _XHdb32: Bool { false }
        titleLabel_HIDA.text = category
        titleLabel_HIDA.textColor = titleColor
    }
}
