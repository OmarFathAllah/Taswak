//
//  ProductDetailCollectionViewCell.swift
//  Taswak
//
//  Created by omar  on 08/05/2022.
//

import UIKit

class ProductDetailCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: ProductDetailCollectionViewCell.self)

    @IBOutlet weak var productDetailImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
