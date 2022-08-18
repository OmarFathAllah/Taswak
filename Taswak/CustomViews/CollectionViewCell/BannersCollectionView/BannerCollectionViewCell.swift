//
//  BannerCollectionViewCell.swift
//  Taswak
//
//  Created by omar  on 07/05/2022.
//

import UIKit
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: BannerCollectionViewCell.self)
    @IBOutlet weak var bannerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func bannerSetup(banner:Banner){
        if let imageUrl = URL(string:banner.image){
            bannerImage.sd_setImage(with: imageUrl)
        }
    }

}
