//
//  CategoriesTableViewCell.swift
//  Taswak
//
//  Created by omar  on 07/03/2022.
//

import UIKit
import SDWebImage
class CategoriesTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: CategoriesTableViewCell.self)

    @IBOutlet weak var CategoryTabelViewTitle: UILabel!
    @IBOutlet weak var categoryTabelViewDescribtion: UILabel!
    @IBOutlet weak var categoryTabelViewImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryTabelViewImage.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func categoryTabelViewSetUp(category: Category){
        if let imageURL = URL(string: category.image){
            categoryTabelViewImage.sd_setImage(with: imageURL)

            CategoryTabelViewTitle.text = category.name
        
        }
    }
}

