//
//  ProfileViewController.swift
//  Taswak
//
//  Created by omar  on 21/07/2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.signedInUserData = nil
        UserDefaults.standard.IsSignedIn = false
        let vc = storyboard?.instantiateViewController(identifier: LoginVC.identifier)as! LoginVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    

}
