//
//  CategpriesViewController.swift
//  Taswak
//
//  Created by omar  on 07/03/2022.
//

import UIKit
import ProgressHUD

class CategpriesViewController: UIViewController {
    
    static let identifier = String(describing: CategpriesViewController.self)
    var categories:[Category] = []
    @IBOutlet weak var categoriesTabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoriesTabelView.delegate = self
        categoriesTabelView.dataSource = self

        cellRegister()
        ProgressHUD.show()
        NetworkService.shared.fetchAllCategories { (result) in
            switch result{
            
            case .success(let decodedData):
                self.categories = decodedData.data.data
                ProgressHUD.dismiss()
                DispatchQueue.main.async {
                    self.categoriesTabelView.reloadData()
                    
                }
//                print(self.categories)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func cellRegister(){
        categoriesTabelView.register(UINib(nibName: CategoriesTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoriesTableViewCell.identifier)
    }
}

extension CategpriesViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
        print("categories array count: \(categories.count)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoriesTableViewCell.identifier) as! CategoriesTableViewCell
        cell.categoryTabelViewSetUp(category: categories[indexPath.row])
        print("Index path . row is : \(indexPath.row)")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let vc = (storyboard?.instantiateViewController(identifier: OneCategoryVC.identifier))!as OneCategoryVC
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        vc.categoryId = categories[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

