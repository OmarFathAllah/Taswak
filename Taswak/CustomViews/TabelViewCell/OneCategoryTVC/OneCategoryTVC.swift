//
//  OneCategoryTVC.swift
//  Taswak
//
//  Created by omar  on 17/03/2022.
//

import UIKit

class OneCategoryTVC: UITableViewCell {
    
    static let identifier = String(describing: OneCategoryTVC.self)
    var favoriteButtonPressed:(()->())?
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func productSetupCell(OneProduct: OneProduct){
        if let imageUrl = URL(string: OneProduct.image){
            productImage.sd_setImage(with: imageUrl)
        }
        productTitle.text = OneProduct.name
        if let price = OneProduct.price{
            productPrice.text = "price " + String(price) + " $"
        }
        likeBtn.contentHorizontalAlignment = .fill
        likeBtn.contentVerticalAlignment = .fill
        likeBtn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    @IBAction func favoriteButtonPressed(_sender: UIButton){
        favoriteButtonPressed?()
    }
}
