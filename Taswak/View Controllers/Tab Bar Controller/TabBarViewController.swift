//
//  TabBarViewController.swift
//  Taswak
//
//  Created by omar  on 27/07/2022.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate {
    let productDetailVC = ProductDetailViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(tabBarController.selectedIndex)
        if (tabBarController.selectedIndex == 2) || tabBarController.selectedIndex == 3 {
            if UserDefaults.standard.IsSignedIn{
                selectedIndex = tabBarController.selectedIndex
            }else{
                alert(title: "Alert!", message: "Please Login First to see your items")
            }
            }
    }
//    Alern Function
    func alert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Home", style: .default) { (okHandler) in
            self.selectedIndex = 0
        }
        let loginAction = UIAlertAction(title: "Login", style: .default) { (action) in
            let vc = self.storyboard?.instantiateViewController(identifier: LoginVC.identifier)as! LoginVC
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
        alert.addAction(okAction)
        alert.addAction(loginAction)
        present(alert, animated: true, completion: nil)
    }
}
