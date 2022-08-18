//
//  SignUpVC.swift
//  Taswak
//
//  Created by omar  on 18/05/2022.
//

import UIKit
import ProgressHUD

class SignUpVC: UIViewController {
    let identifer = "SignUpVC"
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var buttonToSignInView: UIButton!
    
    var registerData: RegisterResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.isEnabled = false
        signUpButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        setTitleForHaveAccountButton()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        textFieldChange()
    }
    override func viewWillAppear(_ animated: Bool) {
        textFieldChange()

    }
    // MARK: -  SignUp Button Pressed

    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        
        guard let name = nameTF.text,name.count > 0 else { return }
        guard let phone = phoneTF.text,phone.count > 0 else { return }
        guard let email = emailTF.text,email.count > 0 else { return }
        guard let password = passwordTF.text,password.count > 0 else { return }
        ProgressHUD.show()

        let parameters = ["name": name, "phone": phone, "email": email, "passord": password,"image":""]
        
        NetworkService.shared.register(parameters: parameters) { (result) in
            switch result{
            case .success(let registerResponse):
                ProgressHUD.dismiss()
                self.registerData = registerResponse
                switch registerResponse.status {
                case true:
                    self.alert(title: "Done", message: registerResponse.message)
                case false:
                    self.alert(title: "Error", message: registerResponse.message)
                }
//                print(self.registerData)
            case .failure(let error):
                print("Failed to register: \(error)")
            }
        }
    }
    // MARK: -  Lestining to any editing change in all text fields

    func textFieldChange(){
        nameTF.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        phoneTF.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        emailTF.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
    }
    
    @objc func handleTextInputChange(){
        let isFormValid = nameTF.text?.count ?? 0 > 0 && phoneTF.text?.count ?? 0 > 0 && emailTF.text?.count ?? 0 > 0 && passwordTF.text?.count ?? 0 > 0
        if isFormValid{
            signUpButton.isEnabled = true
            signUpButton.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        } else{
            signUpButton.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
            signUpButton.isEnabled = false
        }
    }
    
    // MARK: -  setting Title for Already have account?  SignIn Button
    
    func setTitleForHaveAccountButton() {
        let attributedTitle = NSMutableAttributedString(string: "Already Have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        
        attributedTitle.append(NSAttributedString(string: "SignIn", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14),NSAttributedString.Key.foregroundColor:UIColor(red: 0 / 255, green: 128/255, blue: 255/255, alpha: 1)]))
        buttonToSignInView.setAttributedTitle(attributedTitle, for: .normal)
    }

    // MARK: -  Alert Function Not used in our code

    func alert(title:String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAlertButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAlertButton)
        present(alert, animated: true, completion: nil)
    }
    // MARK: -  to dismiss current view to go to login view

    @IBAction func alreadyHaveAccountSignInButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
