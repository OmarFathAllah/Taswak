//
//  CartCustomView.swift
//  Taswak
//
//  Created by omar  on 26/07/2022.
//

import UIKit
class CartCustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 13
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5
    }
}
