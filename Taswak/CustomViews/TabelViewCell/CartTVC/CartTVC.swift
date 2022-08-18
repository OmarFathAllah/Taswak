//
//  CartTVC.swift
//  Taswak
//
//  Created by omar  on 21/05/2022.
//

import UIKit
protocol CartVCDelegate {
    func didDeleteButtonPressed(productId:Int)
}

class CartTVC: UITableViewCell {
    
    static let identifier = String(describing: CartTVC.self)
    var delegate:CartVCDelegate?
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var cartProductName: UILabel!
    @IBOutlet weak var cartProductNewPrice: UILabel!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var quantityLabel: UILabel!
    //    @IBOutlet weak var cartProductOldPrice: UILabel!
    var productId:Int?
    var increaseQuantity:(()->())?
    var decreaseQuantity:(()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func cartItemSetup(cartItem:CartItem) {
        if let imageUrl = URL(string: cartItem.product.image){
            cartImageView.sd_setImage(with: imageUrl)
        }
        cartProductName.text = cartItem.product.name
        let price = Int(cartItem.product.price)
        let oldPrice = Int(cartItem.product.oldPrice)
        cartProductNewPrice.text = "Price \(price) EGP"
//        cartProductOldPrice.text = "Old Price $\(oldPrice)"
        productId = cartItem.product.id
    }
    
    @IBAction func deleteButtonPressed(_sender:UIButton){
        if let productId = productId{
            delegate?.didDeleteButtonPressed(productId:productId)
        }
    }
    @IBAction func plusButtonPressed(){
        increaseQuantity?()
    }
    @IBAction func minusButtonPressed(){
        decreaseQuantity?()
    }
}
