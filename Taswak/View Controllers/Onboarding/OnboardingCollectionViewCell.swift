//
//  onboardingCollectionViewCell.swift
//  Taswak
//
//  Created by omar  on 04/03/2022.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var onboardingTitleLBL: UILabel!
    @IBOutlet weak var onboardingImage: UIImageView!
    @IBOutlet weak var onboardingDescribtionLBL: UILabel!
    
    func setUp(slide: OnboardingSlide){
        onboardingImage.image = slide.image
        onboardingTitleLBL.text = slide.title
        onboardingDescribtionLBL.text = slide.describtion
    }
}
