//
//  CartVC.swift
//  Taswak
//
//  Created by omar  on 08/04/2022.
//

import UIKit
import ProgressHUD

class CartVC: UIViewController {
    
    // MARK: -  properities and outlets
    static let identifier = String(describing: CartVC.self)
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet var subTotalCost: UILabel!
    @IBOutlet var deliveryCost: UILabel!
    @IBOutlet var totalCost: UILabel!
    @IBOutlet var finalizeOrderButton: UIButton!
    var cartItems:[CartItem]?
    var productQuantity:Int = 1
    let authToken = UserDefaults.standard.signedInUserData?.token
    
    // MARK: -  view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Cart Items"
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
        finalizeOrderButton.cornerRadius = 20
        
        cellRegister()
        ProgressHUD.show()
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchCartItems()
    }
    
//    tab bar items badges
    func addBadges(){
        if let tabBarItems = tabBarController?.tabBar.items{
            let tabItem = tabBarItems[3]
            guard let cartItemArray = cartItems else { return }
                if cartItemArray.count == 0{
                    tabItem.badgeValue = nil
                }else{
                    tabItem.badgeValue = "\(cartItemArray.count)"
                }
        }
    }
    
    // MARK: -  calling api to get Cart items for aspecific user
    func fetchCartItems(){
        guard let userToken = authToken else { return }
        let header = ["Authorization":userToken]
//        let header = ["Authorization":"MIaDBArYa4kzsAqW4RvzuN5zVHya1uwBFIo9VAwmXuuWuzTlBT7KCO5TJMYaEk5Z1oWpaP"]
        NetworkService.shared.getCart(headers: header) { (result) in
            switch result{
            case .success(let cartItemResponse):
                let cartProduct = cartItemResponse.data.cartItems
                self.cartItems = cartProduct
                self.addBadges()
                ProgressHUD.dismiss()
                self.cartTableView.reloadData()
                let total = Int(cartItemResponse.data.total)
                self.subTotalCost.text = "Sub Total Amount     \(total) EGP"
                self.totalCost.text = "Total Amount          \(total) EGP"
                self.deliveryCost.text = "Total delivery cost        00 EGP"

//                print(self.cartItems)
            case .failure(let error):
                print(error)
            }
        }
    }
    func cellRegister(){
        cartTableView.register(UINib(nibName: CartTVC.identifier, bundle: nil), forCellReuseIdentifier: CartTVC.identifier)
    }
}

// MARK: -  extension to table view delegate and data source
extension CartVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTVC.identifier)as! CartTVC
        cell.cartItemSetup(cartItem: cartItems![indexPath.row])
        cell.delegate = self
        cell.quantityLabel.text = "\(productQuantity)"
        cell.increaseQuantity = {
            cell.quantityLabel.text = "\(self.productQuantity + 1)"
            self.productQuantity += 1
        }
        cell.decreaseQuantity = {
            cell.quantityLabel.text = "\(self.productQuantity - 1)"
            self.productQuantity -= 1
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

// MARK: -  extension to implement Cart table view cell protocol to current view controller
extension CartVC:CartVCDelegate{
    func didDeleteButtonPressed(productId: Int) {
        ProgressHUD.show()
        guard let userToken = authToken else { return }
        let header = ["Authorization":userToken]
        let parameters = ["product_id":productId]
        NetworkService.shared.addOrDeleteToCart(headers: header, parameters: parameters as [String : Any]) { (result) in
            switch result{
            case .success(let cartResponse):
                switch cartResponse.status {
                case true:
                    ProgressHUD.dismiss()
//                    print(cartResponse.message)
                    self.fetchCartItems()
                    self.alert(title: "Done", message: cartResponse.message)
                case false:
//                    print(cartResponse.message)
                    self.alert(title: "Error", message: cartResponse.message)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    // MARK: -  Alert Function
    func alert(title:String,message:String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let OkAlertAction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(OkAlertAction)
        present(alert, animated: true, completion: nil)
    }
    
}


