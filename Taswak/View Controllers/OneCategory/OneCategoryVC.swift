//
//  OneCategoryVC.swift
//  Taswak
//
//  Created by omar  on 17/03/2022.
//

import UIKit
import ProgressHUD

class OneCategoryVC: UIViewController {
    
    // MARK: -  outlets and variables
    static let identifier = String(describing: OneCategoryVC.self)
    var categoryId:Int!
    var selectedProductId:Int?
    var categoryName:String!
    let authToken = UserDefaults.standard.signedInUserData?.token
    var oneCategoryArray:[OneProduct] = []
    @IBOutlet weak var oneCategoryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = categoryName
        oneCategoryTableView.delegate = self
        oneCategoryTableView.dataSource = self

        registerCell()
        ProgressHUD.show()
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.IsSignedIn{
            loggedInProducts(authToken:self.authToken,categoryId:self.categoryId)
        }else{
            notLogedInProducts(categoryId: self.categoryId)
        }
    }
    
//    get one category products if user loged in
    func loggedInProducts(authToken:String?,categoryId:Int){
        ProgressHUD.show()
        guard let userToken = authToken else { return }
        let header = ["Authorization":userToken]
            NetworkService.shared.fetchOneCategory(header:header,categoryId: categoryId) { (result) in
                switch result{
                case .success(let oneCategory):
                    self.oneCategoryArray = oneCategory.data.data
                    ProgressHUD.dismiss()
    //                print(self.oneCategoryArray)
                    DispatchQueue.main.async {
                        self.oneCategoryTableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
        
//    get one category products if user does not loged in 
    func notLogedInProducts(categoryId:Int){
        NetworkService.shared.fetchOneCategory(header:nil,categoryId: categoryId) { (result) in
            switch result{
            case .success(let oneCategory):
                self.oneCategoryArray = oneCategory.data.data
                ProgressHUD.dismiss()
//                print(self.oneCategoryArray)
                DispatchQueue.main.async {
                    self.oneCategoryTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
            
    }
    
    func registerCell(){
        oneCategoryTableView.register(UINib(nibName: OneCategoryTVC.identifier, bundle: nil), forCellReuseIdentifier: OneCategoryTVC.identifier)
    }
    // MARK: -  add or delete favorite products
    func addOrDeleteFavorite(selectedProductId:Int) {
        ProgressHUD.show()
        if let userToken = authToken {
            let header = ["Authorization":userToken]
            let parameters = ["product_id":selectedProductId]
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

// MARK: -  Extention To implement TableView Delegate and DataSource
extension OneCategoryVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oneCategoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OneCategoryTVC.identifier)as!OneCategoryTVC
        cell.productSetupCell(OneProduct: oneCategoryArray[indexPath.row])
        if oneCategoryArray[indexPath.row].inFavorites{
            cell.likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            cell.likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        cell.favoriteButtonPressed = {
            if UserDefaults.standard.IsSignedIn{
                self.selectedProductId = self.oneCategoryArray[indexPath.row].id
                guard let productId = self.selectedProductId else { return }
                self.addOrDeleteFavorite(selectedProductId:productId)
                    if cell.likeBtn.currentImage == UIImage(systemName: "heart"){
                        cell.likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    }else{
                        cell.likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                    }
            }else{
                self.alert(title: "Error", message: "Please Login First")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(identifier: ProductDetailViewController.identifier)as! ProductDetailViewController
        controller.product = oneCategoryArray[indexPath.row]
        controller.productImages = oneCategoryArray[indexPath.row].images
//        print(controller.product)
        navigationController?.pushViewController(controller, animated: true)
    }
}

