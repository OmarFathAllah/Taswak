//
//  LabelView.swift
//  Taswak
//
//  Created by omar  on 07/03/2022.
//

import UIKit
class LabelView: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeSetup()
    }
    private func initializeSetup(){
        layer.cornerRadius = 15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.5

    }
}

