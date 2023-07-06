//
//  SearchResultViewController.swift
//  Foody
//
//  Created by halil yılmaz on 24.06.2023.
//

import UIKit
import Firebase

class SearchResultViewController: UIViewController {
    
    private let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    var searchResults: [DiscoveryService.User] = [] {
        didSet {
            tvMain.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        registerCell()
    }
    
    func setupUI() {
        view.addSubview(tvMain)
        
        tvMain.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tvMain.delegate = self
        tvMain.dataSource = self
    }
    
    func registerCell() {
        tvMain.register(ProfilSearchCardCell.self, forCellReuseIdentifier: ProfilSearchCardCell.identifier)
    }
}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfilSearchCardCell.identifier, for: indexPath) as! ProfilSearchCardCell
        let user = searchResults[indexPath.row]
        cell.setData(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = searchResults[indexPath.row]
        
        let profileVC = ProfilViewController()
        profileVC.isFollowShow = false
        //profileVC.user = selectedUser
        
        let navigationController = UINavigationController(rootViewController: profileVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

extension SearchResultViewController {
    func searchUsers(withKeyword keyword: String) {
        DiscoveryService.shared.searchUsers(withKeyword: keyword) { [weak self] (users, error) in
            if let error = error {
                print("Error searching users: \(error)")
                return
            }
            
            // Arama sonuçlarını kullanarak tableView'ı güncelleyin
            self?.searchResults = users ?? []
        }
    }
}

//extension SearchResultViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {
//            return
//        }
//
//        DiscoveryService.shared.searchUsers(withKeyword: text) { [weak self] (users, error) in
//            if let error = error {
//                print("Error searching users: \(error)")
//                return
//            }
//
//            self?.searchResults = users ?? []
//        }
//    }
//}
