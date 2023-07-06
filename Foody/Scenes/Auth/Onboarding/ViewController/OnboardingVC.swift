//
//  OnboardingViewController.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    var viewModel: OnboardingViewModel = {
        .init()
    }()
    
    var onboardingView = OnboardingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onboardingView.onboardingCollection.delegate = self
        self.onboardingView.onboardingCollection.dataSource = self
        onboardingView.onboardingCollection.showsVerticalScrollIndicator = false
        customizeNavBar()
        setupUI()
        registerCell()
        onboardingView.delegate = self
        skipShow(false)
    }
    
    
    private func customizeNavBar() {
        navigationController?.isNavigationBarHidden = true
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back to Guide", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .black
    }
    
    func setupUI(){
        view.addSubview(onboardingView)
        
        onboardingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func registerCell(){
        onboardingView.onboardingCollection.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
    }
}


extension OnboardingViewController: OnboardingViewDelegate {
    func didTapStartButton() {
        skipShow(true)
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSkipButton() {
        skipShow(true)
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapContinueButton() {
        let currentIndex = onboardingView.onboardingCollection.indexPathsForVisibleItems.first?.row ?? 0
            let nextIndex = currentIndex + 1
            
            if nextIndex < self.viewModel.titleArray.count {
                let indexPath = IndexPath(row: nextIndex, section: 0)
                onboardingView.onboardingCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                onboardingView.pageControl.currentPage = nextIndex
                
                if nextIndex == self.viewModel.titleArray.count - 1 {
                    skipShow(true) // Son sayfadan bir önceki indexteyiz, continueButton'u gizle
                }
            } else {
                skipShow(true) // Son sayfaya gelindi, continueButton'u gizle
            }
    }
    
    func didTapValueChanged() {
        self.showItem(at: onboardingView.pageControl.currentPage)
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as! OnboardingCell
        cell.onboardingImageView.image = self.viewModel.imageArray[indexPath.row]
        cell.slideTitleLabel.text = self.viewModel.titleArray[indexPath.row]
        cell.slideSubtitleLabel.text = self.viewModel.subTitleArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    // Scroll
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1)
        onboardingView.pageControl.page = page
        
        skipShow(page == 2)
    }
}

extension OnboardingViewController {
    func showItem(at index: Int) {
        skipShow(index == 2)
        onboardingView.pageControl.page = index
        let indexPath = IndexPath(item: index, section: 0)
        onboardingView.onboardingCollection.scrollToItem(at: indexPath, at: [.centeredHorizontally,.centeredVertically], animated: true)
    }
    
    func normalize(value: CGFloat) -> CGFloat {
        let scale = UIScreen.main.bounds.width / 375.0
        return value * scale
    }
    
    func skipShow(_ bool: Bool) {
        onboardingView.startButton.isHidden = !bool
        onboardingView.contiuneButton.isHidden = bool
    }
}
