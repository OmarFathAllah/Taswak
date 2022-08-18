//
//  SearchViewController.swift
//  Taswak
//
//  Created by omar  on 23/07/2022.
//

import UIKit
import ProgressHUD

class SearchViewController: UIViewController{
    
//    properties
    static let identifier = String(describing: SearchViewController.self)
    var products:[OneProduct] = []
    var selectedProductId: Int?
    let authToken = UserDefaults.standard.signedInUserData?.token
    @IBOutlet var searchTF: UISearchBar!
    @IBOutlet var productsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        
        searchTF.delegate = self
        
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let parameters = ["text":""]
        if UserDefaults.standard.IsSignedIn{
        getAllProducts(authToken: self.authToken, parameters: parameters)
        }else{
            notLogedInProducts(parameters: parameters)
        }
  }
    
//    calling api service to get all product so that the the user can search between them
    func getAllProducts(authToken:String?,parameters:[String:Any]){
        ProgressHUD.show()
        guard let userToken = authToken else { return }
        let header = ["Authorization":userToken]
            NetworkService.shared.searchProuducts(headers: header, parameters: parameters) { (result) in
                switch result{
                case .success(let response):
                    ProgressHUD.dismiss()
                    self.products = response.data.data
//                    print(self.products)
                    self.productsCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
//    function to get all product even the user did not loged in
    func notLogedInProducts(parameters:[String:String]){
        NetworkService.shared.searchProuducts(headers: nil, parameters: parameters) { (result) in
            switch result{
            case .success(let response):
                ProgressHUD.dismiss()
                self.products = response.data.data
//                    print(self.products)
                self.productsCollectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    register nib cell function
        func registerCell(){
            productsCollectionView.register(UINib(nibName: ProductsCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductsCollectionViewCell.identifier)
        }
}

// MARK: -  extension to implement collection view delegate and data source
extension SearchViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsCollectionViewCell.identifier, for: indexPath)as! ProductsCollectionViewCell
        cell.delegate = self
        cell.productsSetupCell(product: products[indexPath.row])
        if (products[indexPath.row].inFavorites){
            cell.productLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            cell.productLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        if UserDefaults.standard.IsSignedIn{
            cell.changeLikeButton = {
                self.selectedProductId = self.products[indexPath.row].id
                if cell.productLikeButton.currentImage == UIImage(systemName: "heart"){
                    cell.productLikeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                }else{
                    cell.productLikeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
            }
        }
        return  cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: ProductDetailViewController.identifier)as! ProductDetailViewController
        vc.product = products[indexPath.row]
        vc.productImages = products[indexPath.row].images
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width / 2.05 , height: view.frame.height / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}

// MARK: -  extension for implementing Search text field delegate
extension SearchViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text{
            let parameters = ["text":searchText]
            if UserDefaults.standard.IsSignedIn{
            getAllProducts(authToken: self.authToken, parameters: parameters)
            }else{
                notLogedInProducts(parameters: parameters)
            }
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let searchText = searchBar.text{
            let parameters = ["text":searchText]
            if UserDefaults.standard.IsSignedIn{
            getAllProducts(authToken: self.authToken, parameters: parameters)
            }else{
                notLogedInProducts(parameters: parameters)
            }
        }
    }
}
// MARK: -  extension to implement productCollectionViewCellDelefate to ad action to cell like button using delegate
extension SearchViewController:ProductsCollectionViewCellDelegate{
    func addOrDeleteFavorite() {
        ProgressHUD.show()
        if let userToken = authToken {
            let header = ["Authorization":userToken]
            let parameters = ["product_id":self.selectedProductId]
            NetworkService.shared.addOrDeleteFavourite(headers: header, parameters: parameters) { (result) in
                switch result{
                case .success(let favouriteResponse):
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
        }else{
            ProgressHUD.dismiss()
            self.alert(title: "Error", message: "Please Login First")
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




