//
//  onboardingViewController.swift
//  Taswak
//
//  Created by omar  on 04/03/2022.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    static let identefier = String(describing: OnboardingViewController.self)
    @IBOutlet weak var onboardingCollectionView: UICollectionView!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    @IBOutlet weak var onboardingNextBtn: UIButton!
    
    
    var slides :[OnboardingSlide] = []
    var pageNumber = 0 {
        didSet {
            onboardingPageControl.currentPage = pageNumber
            if pageNumber == slides.count - 1 {
                onboardingNextBtn.setTitle("Get Started", for: .normal)
            } else {
                onboardingNextBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingCollectionView.delegate = self
        onboardingCollectionView.dataSource = self
        
        slides = [
            OnboardingSlide(title: "Purchase online", describtion: "All things you can imagine are collected for you and can be easily buyed online.", image: #imageLiteral(resourceName: "mobile-shopping-app-icon")),
            OnboardingSlide(title: "Instant World-Wide Delivery", describtion: "Your orders will be delivered instantly irrespective of your location around the world.", image: #imageLiteral(resourceName: "onb2")),
            OnboardingSlide(title: "Buy Anything You Can Imagine", describtion: "All things you can imagine are collected for you and can be easily buyed.", image: #imageLiteral(resourceName: "onb5"))
        ]
        
        onboardingPageControl.numberOfPages = slides.count
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if pageNumber == slides.count - 1 {
            let homeVC = storyboard?.instantiateViewController(identifier: LoginVC.identifier) as! LoginVC
            homeVC.modalTransitionStyle = .flipHorizontal
            homeVC.modalPresentationStyle = .fullScreen
//            useing user defaults to show on boarding view one Time
            UserDefaults.standard.isOnBoarded = true
            present(homeVC, animated: true, completion: nil)
            
        }else{
            pageNumber += 1
            print(pageNumber)
            onboardingPageControl.currentPage = pageNumber
            let indexPath = IndexPath(item: pageNumber, section: 0)
            onboardingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}

// MARK: -  Extension to implement collection view delegate and data source

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as!OnboardingCollectionViewCell
        cell.setUp(slide: slides[indexPath.row])
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        pageNumber = Int(scrollView.contentOffset.x / width)
        print(pageNumber)
        onboardingPageControl.currentPage = pageNumber
    }
}
