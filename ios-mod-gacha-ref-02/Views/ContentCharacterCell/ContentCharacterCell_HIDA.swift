//
//  ContentCharacterCell_HIDA.swift
//
//  Created by Kirill Ponomarenko
//

import UIKit
import Kingfisher

class ContentCharacterCell_HIDA: UICollectionViewCell {

    @IBOutlet weak var contentImageView_HIDA: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        layer.borderWidth = 0
        layer.borderColor = UIColor.clear.cgColor
        layer.backgroundColor = UIColor.tertiary.cgColor
        layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        contentImageView_HIDA.image = nil
        contentImageView_HIDA.kf.indicator?.stopAnimatingView()
        contentImageView_HIDA.contentMode = .scaleAspectFit
    }
    
    func configure_HIDA(with model: EditorContentModel_HIDA) {
        contentImageView_HIDA.add_HIDA(image: model.path.elPath, for: .editor_hida)
        UIImageView.uploadPDF_HIDA(image: model.path.pdfPath)
    }
    
    func configure_HIDA(with image: UIImage) {
        contentImageView_HIDA.image = image
        contentImageView_HIDA.tag = 999996
        contentImageView_HIDA.contentMode = .center
    }
}
