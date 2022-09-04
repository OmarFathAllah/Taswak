//
//  LoginVC.swift
//  Taswak
//
//  Created by omar  on 18/04/2022.
//

import UIKit
import ProgressHUD

class LoginVC: UIViewController {
    var userData: LoginResponse?
    
    static let identifier = String(describing: LoginVC.self)

    @IBOutlet weak var dontHaveAccountSignUp: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        textFieldChange()
        setTitleForDontHaveAccountButton()
        logInButton.isEnabled = false
        logInButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
    }
    
    // MARK: -  Login
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let userName = userNameTextField.text else {return}
        guard let password = passwordTextField.text else {return}
            ProgressHUD.show()
            view.endEditing(true)
            let parameters = ["email":userName, "password":password]
            NetworkService.shared.login(parameters: parameters) { (result) in
                switch result{
                case .success(let loginData):
                    self.userData = loginData
//                    save login data into user deafulats
                    UserDefaults.standard.signedInUserData = loginData.data
//                    print("user login data is: \(UserDefaults.standard.signedInUserData)")
                    ProgressHUD.dismiss()
                    if loginData.status{
                        UserDefaults.standard.IsSignedIn = loginData.status
                        let VC = self.storyboard?.instantiateViewController(identifier: TabBarViewController.identifier)
                        let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
                        appDelegate.window?.rootViewController = VC
                    }else{
                        self.alert(title: "Error", message: loginData.message)
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    // MARK: -  is Logged In
    func isLogedIn(status:Bool)->Bool{
        return status
    }

    // MARK: -  check for form validation
    func textFieldChange(){
        userNameTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    }
    
    @objc func handleTextInputChange(){
        let isFormValid = userNameTextField.text?.count ?? 0 > 0 && passwordTextField.text?.count ?? 0 > 0
        if isFormValid{
            logInButton.isEnabled = true
            logInButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else{
            logInButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            logInButton.isEnabled = false
        }
    }
    
    // MARK: -  Setting attributed title for dont have account button
    func setTitleForDontHaveAccountButton() {
        let attributedTitle = NSMutableAttributedString(string: "Dont have account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "SignUp", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor(red: 0 / 255, green: 128/255, blue: 255/255, alpha: 1)]))
        dontHaveAccountSignUp.setAttributedTitle(attributedTitle, for: .normal)
    }

    // MARK: -  Skip Button
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        let VC = self.storyboard?.instantiateViewController(identifier: TabBarViewController.identifier)
        let appDelegate = UIApplication.shared.connectedScenes.first?.delegate as! SceneDelegate
        appDelegate.window?.rootViewController = VC
    }
    
    // MARK: -  Alert Function
    func alert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAlertButton)
        present(alert, animated: true, completion: nil)
    }
}
