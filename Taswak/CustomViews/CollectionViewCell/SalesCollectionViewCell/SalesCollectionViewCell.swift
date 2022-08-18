//
//  SalesCollectionViewCell.swift
//  Taswak
//
//  Created by omar  on 07/03/2022.
//

import UIKit

class SalesCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: SalesCollectionViewCell.self)

    @IBOutlet weak var salesImage: UIImageView!
    @IBOutlet weak var salesTilteLBL: UILabel!
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var salesPriceLBL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func salesSetup(sales: OneProduct) {
        if let imageURL = URL(string: sales.image){
                salesImage.sd_setImage(with: imageURL)
        }
        salesTilteLBL.text = sales.name
        if let price = sales.price, let discount = sales.discount{
            salesPriceLBL.text = "Price: \(String(price)) LE"
            self.discount.text = "discount: \(String(discount)) %"
        }
        }
    }
