//
//  CategoriesCollectionViewCell.swift
//  Taswak
//
//  Created by omar  on 07/03/2022.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLBL: UILabel!
    static let identifier = String(describing: CategoriesCollectionViewCell.self)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
