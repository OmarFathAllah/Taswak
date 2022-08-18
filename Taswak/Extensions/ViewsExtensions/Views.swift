//
//  Views.swift
//  Taswak
//
//  Created by omar  on 05/03/2022.
//

import UIKit

extension UIView {
   @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius  }
        set{ self.layer.cornerRadius = newValue }
    }
}
