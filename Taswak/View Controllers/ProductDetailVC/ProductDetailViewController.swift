//
//  ProductDetailViewController.swift
//  Taswak
//
//  Created by omar  on 25/03/2022.
//

import UIKit
import SDWebImage
import ProgressHUD

class ProductDetailViewController: UIViewController {
    static let identifier = String(describing: ProductDetailViewController.self)
    var product:OneProduct!
    var productImages:[String]!
    let authToken = UserDefaults.standard.signedInUserData?.token
    var badgeNumber = 0
    @IBOutlet weak var productImageCollectionView: UICollectionView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescribtion: UILabel!
    @IBOutlet weak var productOldPrice: UILabel!
    @IBOutlet weak var productDiscount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Product Details"
        setUpView()
        productImageCollectionView.delegate = self
        productImageCollectionView.dataSource = self
        
        registerCell()
    }
    
    func setUpView() {
        productTitle.text = product.name
        if let discount = product.discount,
           let oldPrice = product.oldPrice,
           let price = product.price {
            productDiscount.text = "Discount: \(discount) %"
            productOldPrice.text = "Old Price: \(oldPrice)"
            productPrice.text = "Price: \(price) LE"
        }
        productDescribtion.text = product.description
        
//        Another way to fetch image from url native way but very slow
//        if let imageURL = URL(string: product.image){
//            if let imageAsData = try? Data(contentsOf: imageURL){
//                productImage.image = UIImage(data: imageAsData)
//            }
//        }
    }
    
    func registerCell(){
        productImageCollectionView.register(UINib(nibName: ProductDetailCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ProductDetailCollectionViewCell.identifier)
    }
    // MARK: -  Add To Cart Section

    @IBAction func addToCartPressed(_ sender: UIButton) {
        badgeNumber += 1
        ProgressHUD.show()
        guard let userToken = authToken else { return }
        let header = ["Authorization":userToken]
        let parameters = ["product_id":product.id]
        NetworkService.shared.addOrDeleteToCart(headers: header, parameters: parameters) { (result) in
            switch result{
            case .success(let cartResponse):
                ProgressHUD.dismiss()
                switch cartResponse.status {
                case true:
                    print(cartResponse.message)
                    self.alert(title: "Done", message: cartResponse.message)
                case false:
                    print(cartResponse.message)
                    self.alert(title: "Error", message: cartResponse.message)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
// MARK: -  Extension for viewController to add  collection view deleget
extension ProductDetailViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductDetailCollectionViewCell.identifier, for: indexPath)as! ProductDetailCollectionViewCell
        let imageUrl = URL(string: productImages[indexPath.row])
        cell.productDetailImage.sd_setImage(with: imageUrl)
        return cell
    }
    
    // MARK: -  Product Image Collection View Cell Size
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.95)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func alert(title:String, message:String){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let okAlertButton = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(okAlertButton)
        present(alert, animated: true, completion: nil)
    }
}

