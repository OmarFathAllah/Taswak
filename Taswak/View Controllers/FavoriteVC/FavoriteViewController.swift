//
//  FavoriteViewController.swift
//  Taswak
//
//  Created by omar  on 25/07/2022.
//

import UIKit
import ProgressHUD

class FavoriteViewController: UIViewController {

    // MARK: -  outlets and variables
    @IBOutlet var favoriteCollectionView: UICollectionView!
    var favorites:[FavDatum] = []
    let authToken = UserDefaults.standard.signedInUserData?.token
    var selectedProductId:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = false
        title = "Favorite"
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
    }
    
    //    tab bar items badges
        func addBadges(){
            if let tabBarItems = tabBarController?.tabBar.items{
                let tabItem = tabBarItems[2]
                if favorites.count == 0{
                    tabItem.badgeValue = nil
                }else{
                    tabItem.badgeValue = "\(favorites.count)"
                }
            }
        }
    
    // MARK: -  get all favorite items from API
    func getFavorites(){
        guard let userToken = authToken else { return }
        let header = ["Authorization":userToken]
        NetworkService.shared.getFavoriteItems(headers: header) { (result) in
            switch result{
            case .success(let favouriteResponse):
                self.favorites = favouriteResponse.data.data
                self.addBadges()
                self.favoriteCollectionView.reloadData()
                ProgressHUD.dismiss()
//                print(self.favorites)
            case .failure(let error):
                print(error)
            }
        }
    }

    func registerCell(){
        favoriteCollectionView.register(UINib(nibName: ProductsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductsCollectionViewCell.identifier)
    }
}

// MARK: -  extention uicollection view delegate and data scource
extension FavoriteViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.identifier, for: indexPath)as! ProductsCollectionViewCell
        cell.delegate = self
        cell.favoriteSetupCell(favorite: favorites[indexPath.row])
        cell.changeLikeButton = {
            self.selectedProductId = self.favorites[indexPath.row].product.id
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.05 , height: view.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK: -  Product Collection View Cell Delegate to remove item from fgavorites
extension FavoriteViewController:ProductsCollectionViewCellDelegate{
    func addOrDeleteFavorite() {
        ProgressHUD.show()
        guard let userToken = authToken else { return }
        let header = ["Authorization":userToken]
        let parameters = ["product_id":self.selectedProductId]
        NetworkService.shared.addOrDeleteFavourite(headers: header, parameters: parameters) { (result) in
            switch result{
            case .success(let favouriteResponse):
                self.getFavorites()
                ProgressHUD.dismiss()
                switch favouriteResponse.status{
                case true:
                    self.alert(title: "Done", message: favouriteResponse.message)
                case false:
                    self.alert(title: "Error", message: favouriteResponse.message)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: -  alert function
    func alert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OkActionButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(OkActionButton)
        present(alert, animated: true, completion: nil)
    }
}


