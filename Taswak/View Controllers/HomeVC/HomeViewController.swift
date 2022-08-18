//
//  HomeViewController.swift
//  Taswak
//
//  Created by omar  on 06/03/2022.


import UIKit
import ProgressHUD

class HomeViewController: UIViewController {
    
    @IBOutlet weak var seeAllCateogriesButton: UIButton!
    @IBOutlet weak var basketButton: UIBarButtonItem!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var cateogriesCollectionView: UICollectionView!
    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var salesCollectionView: UICollectionView!
    
    static let identifier = String(describing: HomeViewController.self)
    var categories : [Category] = []
    var products:[OneProduct] = []
    var banners:[Banner] = []
    var currentIndex = 5
    var timer: Timer?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        cateogriesCollectionView.delegate = self
        cateogriesCollectionView.dataSource = self
        salesCollectionView.delegate = self
        salesCollectionView.dataSource = self
        bannersCollectionView.delegate = self
        bannersCollectionView.dataSource = self
        
        // MARK: -  NetWorking call to fetch All Categories
        ProgressHUD.show()
        NetworkService.shared.fetchAllCategories { (result) in
            switch result{
            case .success(let decodedData):
                self.categories = decodedData.data.data
                ProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.cateogriesCollectionView.reloadData()
                }
//                print(self.categories)
            case .failure(let error):
                print(error)
            }
        }
        // MARK: -  calling Api To fetch Banner and Home Categories
        ProgressHUD.show()
        NetworkService.shared.fetchhomeAndBanner { (result) in
            switch result{
            case .success(let homeAndBanner):
                self.banners = homeAndBanner.data.banners
                ProgressHUD.dismiss()
//                print(self.banners)
                self.products = homeAndBanner.data.products
                DispatchQueue.main.async {
                    self.salesCollectionView.reloadData()
                    self.bannersCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        regiserCells()
        self.startTimer()
    }
    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector (updateCellImage), userInfo: nil, repeats: true)
    }
    
    @objc func updateCellImage(){
        if currentIndex <= banners.count - 1 {
            currentIndex += 1
            bannersCollectionView.scrollToItem(at: IndexPath(item: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }else{
            currentIndex = 0
        }
    }
    
    private func regiserCells() {
        cateogriesCollectionView.register(UINib(nibName: CategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        
        salesCollectionView.register(UINib(nibName: SalesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: SalesCollectionViewCell.identifier)
        
        bannersCollectionView.register(UINib(nibName: BannerCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
    }
    
    // MARK: -  cart Button Pressed
    @IBAction func cartButtonPressed(_sender: UIBarButtonItem){
        if UserDefaults.standard.IsSignedIn{
            let vc = storyboard?.instantiateViewController(identifier: CartVC.identifier)as! CartVC
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = storyboard?.instantiateViewController(identifier: LoginVC.identifier)as! LoginVC
            vc.modalTransitionStyle = .partialCurl
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
}

// MARK: -  ViewController Extension To  add CollectionView delegate and data source
extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case cateogriesCollectionView:
            return categories.count
        case salesCollectionView:
            return products.count
        case bannersCollectionView:
            return banners.count
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cateogriesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath)as! CategoriesCollectionViewCell
            cell.categoryNameLBL.text = categories[indexPath.row].name
            return cell
        }else if collectionView == salesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SalesCollectionViewCell.identifier, for: indexPath)as! SalesCollectionViewCell
            cell.salesSetup(sales: products[indexPath.row])
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath)as!BannerCollectionViewCell
            cell.bannerSetup(banner: banners[indexPath.row])
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == cateogriesCollectionView{
            return CGSize(width: collectionView.frame.width * 0.3, height: collectionView.frame.height * 0.45)
        }else if collectionView == salesCollectionView{
            return CGSize(width: collectionView.frame.width * 0.45, height: collectionView.frame.height * 0.85)
        }else{
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height * 0.90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView{
        case cateogriesCollectionView: return 10
        case salesCollectionView: return 10
        case bannersCollectionView: return 0
        default:
            return 2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == cateogriesCollectionView{
            return 0.2
        }else{
            return 0.2
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch collectionView {
        case salesCollectionView:
            return UIEdgeInsets(top: 20, left: 5, bottom: 20, right: 5)
        case cateogriesCollectionView:
            return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 1)
        default:
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case cateogriesCollectionView:
            let controller = storyboard?.instantiateViewController(identifier: OneCategoryVC.identifier) as! OneCategoryVC
            controller.categoryId = categories[indexPath.row].id
            controller.categoryName = categories[indexPath.row].name
            navigationController?.pushViewController(controller, animated: true)
        case salesCollectionView:
            let controller = storyboard?.instantiateViewController(identifier: ProductDetailViewController.identifier) as! ProductDetailViewController
            controller.product = products[indexPath.row]
            controller.productImages = products[indexPath.row].images
            navigationController?.pushViewController(controller, animated: true)
        default:
            ""
        }
    }
}

