//
//  ProfileViewController.swift
//  Taswak
//
//  Created by omar  on 21/07/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var loginLogoutButton: UIButton!
    @IBOutlet weak var profileListTableView: UITableView!
    var profileList:[ProfileList] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerProfileCell()
        getProfileListDataFRomJSONFile()
        changeLoginButtonTitle()
    }
    
    // MARK: -  register profile table view cell
    func registerProfileCell(){
        profileListTableView.register(UINib(nibName: ProfileListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProfileListTableViewCell.identifier)
        profileListTableView.delegate = self
        profileListTableView.dataSource = self
    }
    
    // MARK: -  JSON Decoding Function
    func getProfileListDataFRomJSONFile(){
        guard let profileListUrl = Bundle.main.url(forResource: "ProfileList", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: profileListUrl)
            let decodedData = try JSONDecoder().decode([ProfileList].self, from: data)
            self.profileList = decodedData
            profileListTableView.reloadData()
        } catch let error {
            print(error)
        }
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIButton) {
        switch sender.currentTitle {
        case "LogOut":
            UserDefaults.standard.signedInUserData = nil
            UserDefaults.standard.IsSignedIn = false
            alert(title: nil, message: nil)
        default:
            goToLoginVC()
        }
      
    }
    
//    change login button title
    func changeLoginButtonTitle(){
        if UserDefaults.standard.IsSignedIn{
            loginLogoutButton.setTitle("LogOut", for: .normal)
        }else{
            loginLogoutButton.setTitle("LogIn", for: .normal)
        }
    }
    
//    alert function
    func alert(title:String?, message:String?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let OkAction = UIAlertAction(title: "Log out", style: .destructive) { (_) in
            self.goToLoginVC()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("cancel action pressed")
        })
        alert.addAction(OkAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
//    Go to Login view controller function
    func goToLoginVC(){
        let vc = self.storyboard?.instantiateViewController(identifier: LoginVC.identifier)as! LoginVC
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}

// MARK: -  extension profile table view delegate and datat scource
extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileListTableViewCell.identifier, for: indexPath)as! ProfileListTableViewCell
        cell.profileListNameLabel.text = profileList[indexPath.row].title
        cell.profileListImage.image = UIImage(named: profileList[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

