//
//  DiscoveryViewController.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit
import SnapKit

class DiscoveryViewController: UIViewController {

    let searchController = UISearchController(searchResultsController: SearchResultViewController())

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        
        setupUI()
        registerCell()
    }
    
    func setupUI() {
        view.addSubview(collectionView)

        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func registerCell() {
        collectionView.register(DiscoverRecipeCardCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverRecipeCardCollectionViewCell.identifier)
    }
}

extension DiscoveryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverRecipeCardCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.size.width / 2) - 3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailRecipeVC = DetailRecipeVC()
        let navigationController = UINavigationController(rootViewController: detailRecipeVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

extension DiscoveryViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        
        if let searchResultsController = searchController.searchResultsController as? SearchResultViewController {
            DiscoveryService.shared.searchUsers(withKeyword: text) { [weak searchResultsController] (users, error) in
                if let error = error {
                    print("Error searching users: \(error)")
                    return
                }
                
                searchResultsController?.searchResults = users ?? []
            }
        }
    }
}
/*
 
 class DiscoveryViewController: UIViewController {

     let searchController = UISearchController(searchResultsController: SearchResultViewController())

     private let collectionView = UICollectionView(
         frame: .zero,
         collectionViewLayout: UICollectionViewFlowLayout()
     )
     
     override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = .systemBackground
         
         navigationItem.searchController = searchController
         searchController.searchResultsUpdater = self
         
         collectionView.delegate = self
         collectionView.dataSource = self
         collectionView.showsVerticalScrollIndicator = false
         
         setupUI()
         registerCell()
     }
     
     func setupUI() {
         view.addSubview(collectionView)

         collectionView.snp.makeConstraints { make in
             make.top.equalTo(view.safeAreaLayoutGuide)
             make.leading.equalToSuperview()
             make.trailing.equalToSuperview()
             make.bottom.equalToSuperview()
         }
     }
     
     func registerCell() {
         collectionView.register(DiscoverRecipeCardCollectionViewCell.self, forCellWithReuseIdentifier: DiscoverRecipeCardCollectionViewCell.identifier)
     }
 }

 extension DiscoveryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 3
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscoverRecipeCardCollectionViewCell.identifier, for: indexPath)
         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let width = (view.frame.size.width / 2) - 3
         return CGSize(width: width, height: width)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 1
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 1
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 1, left: 2, bottom: 1, right: 2)
     }
     
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let detailRecipeVC = DetailRecipeVC()
         let navigationController = UINavigationController(rootViewController: detailRecipeVC)
         navigationController.modalPresentationStyle = .fullScreen
         present(navigationController, animated: true, completion: nil)
     }
 }

 extension DiscoveryViewController: UISearchResultsUpdating {
     func updateSearchResults(for searchController: UISearchController) {
         guard let text = searchController.searchBar.text else {
             return
         }
         
         if let searchResultsController = searchController.searchResultsController as? SearchResultViewController {
             DiscoveryService.shared.searchUsers(withKeyword: text) { [weak searchResultsController] (users, error) in
                 if let error = error {
                     print("Error searching users: \(error)")
                     return
                 }
                 
                 searchResultsController?.searchResults = users ?? []
             }
         }
     }
 }
 
 
 */
