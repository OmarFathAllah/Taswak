//
//  ProductsCollectionViewCell.swift
//  Taswak
//
//  Created by omar  on 23/07/2022.
//

import UIKit
protocol ProductsCollectionViewCellDelegate {
    func addOrDeleteFavorite()
}

class ProductsCollectionViewCell: UICollectionViewCell {

    static let identifier = String(describing: ProductsCollectionViewCell.self)
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTilteLBL: UILabel!
    @IBOutlet weak var productPriceLBL: UILabel!
    @IBOutlet var productLikeButton: UIButton!
    var delegate:ProductsCollectionViewCellDelegate?
    var changeLikeButton:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    // MARK: -  products Setup cell function
    func productsSetupCell(product: OneProduct) {
        if let imageURL = URL(string: product.image){
            productImage.sd_setImage(with: imageURL)
        }
        productTilteLBL.text = product.name
        if let price = product.price{
            productPriceLBL.text = "Price: \(String(price)) LE"
        }
        productLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        productLikeButton.contentVerticalAlignment = .fill
        productLikeButton.contentHorizontalAlignment = .fill
        productLikeButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    // MARK: -  Favorite cell setup function
    func favoriteSetupCell(favorite: FavDatum){
        if let imageURL = URL(string: favorite.product.image){
            productImage.sd_setImage(with: imageURL)
        }
        productTilteLBL.text = favorite.product.name
        productPriceLBL.text = "Price: \(String(favorite.product.price)) LE"
        productLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        productLikeButton.contentVerticalAlignment = .fill
        productLikeButton.contentHorizontalAlignment = .fill
        productLikeButton.imageEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
    }
    // MARK: -  like button pressed action
    @IBAction func likeButtonPressed(_ sender: UIButton) {
       changeLikeButton?()
        delegate?.addOrDeleteFavorite()
    }
}
