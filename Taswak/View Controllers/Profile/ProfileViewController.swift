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
//        observerIsLogedIn()
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
        UserDefaults.standard.signedInUserData = nil
        UserDefaults.standard.IsSignedIn = false
        let vc = storyboard?.instantiateViewController(identifier: LoginVC.identifier)as! LoginVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
    }
    
    // MARK: -  adding observer for is loged in notification intialized in Login View Controller
    func observerIsLogedIn(){
        NotificationCenter.default.addObserver(self, selector: #selector(changeLoginButtonInProfile), name: NSNotification.Name("isLogedInNotification"), object: nil)
    }
    @objc func changeLoginButtonInProfile(){
        print("notification center done")
        loginLogoutButton.setTitle("Log Out", for: .normal)
    }
//    change login button title
    func changeLoginButtonTitle(){
        if UserDefaults.standard.IsSignedIn{
            loginLogoutButton.setTitle("LogOut", for: .normal)
        }else{
            loginLogoutButton.setTitle("LogIn", for: .normal)
        }
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

