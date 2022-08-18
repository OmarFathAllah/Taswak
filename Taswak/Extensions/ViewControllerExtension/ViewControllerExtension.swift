//
//  ViewControllerExtension.swift
//  Taswak
//
//  Created by omar  on 23/03/2022.
//

import UIKit

extension UIViewController {
    
    var identifier: String{
        return String(describing: self)
    }
    func instantiate() -> Self {
        let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
        let controller = storyboard?.instantiateViewController(identifier: identifier)as! Self
        return controller
    }
}
