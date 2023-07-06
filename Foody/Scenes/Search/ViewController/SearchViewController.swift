//
//  SearchVC.swift
//  Foody
//
//  Created by halil yılmaz on 23.06.2023.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    var viewModel: SearchViewModel = {
        .init()
    }()
    
    let searchController = UISearchController(searchResultsController: SearchResultVC())
    
    private let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    let searchButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Search", for: .normal)
        btn.backgroundColor = .systemBlue
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
         definesPresentationContext = true
        tvMain.delegate = self
        tvMain.dataSource = self
        tvMain.reloadData()
        setupUI()
        registerCell()
    }
    
    func setupUI() {
        view.addSubview(tvMain)
        
        tvMain.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview()
        }
    }
    
    func registerCell(){
        tvMain.register(MaterialListCell.self, forCellReuseIdentifier: MaterialListCell.identifier)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.materialsTool.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.materialsTool[section].learnType
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.materialsTool[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MaterialListCell.identifier, for: indexPath) as! MaterialListCell
        cell.sectionLabel.text = viewModel.materialsTool[indexPath.section].list[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .systemOrange.withAlphaComponent(0.9)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .secondarySystemBackground
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let selectedValue = viewModel.materialsTool[indexPath.section].list[indexPath.row]
        
        if cell?.accessoryType == .checkmark {
            cell?.accessoryType = .none
            self.viewModel.selectedItems.remove(selectedValue)
        } else {
            cell?.accessoryType = .checkmark
            self.viewModel.selectedItems.insert(selectedValue)
        }
        
        print(viewModel.selectedItems)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        let vc = searchController.searchResultsController as? SearchResultVC
        print(text)
        
        // Açılan sayfayı present olarak göster
        let presentedViewController = SearchResultVC() // Değiştirilmesi gereken view controller örneği
        self.present(presentedViewController, animated: true, completion: nil)
    }
}
