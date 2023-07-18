//
//  SearchByMaterialsVC.swift
//  Foody
//
//  Created by halil yılmaz on 15.07.2023.
//

import UIKit
import SnapKit

class SearchByMaterialsVC: UIViewController {
    
    var keywordsList: [String] = []
    
    var viewModel: SearchViewModel = SearchViewModel()
    
    private let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.tvMain.delegate = self
        self.tvMain.dataSource = self
        
        setupUI()
        registerCell()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.didFetchSearchRecipies = { [weak self] recipes, error in
            if let error = error {
                print("Error fetching recipes: \(error)")
                return
            }
            DispatchQueue.main.async {
                self?.viewModel.searchResultsbyMaterial = recipes ?? []
                self?.tvMain.reloadData()
            }
        }
        
        viewModel.searchRecipesByMaterial(withKeyword: keywordsList)
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Malzemelere göre tarifler"
    }
    
    func registerCell() {
        tvMain.register(RecipeCardSearchCell.self, forCellReuseIdentifier: RecipeCardSearchCell.identifier)
    }
    
    func setupUI(){
        view.addSubview(tvMain)
        
        tvMain.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
}
extension SearchByMaterialsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultsbyMaterial.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCardSearchCell.identifier, for: indexPath) as! RecipeCardSearchCell
        let result = viewModel.searchResultsbyMaterial[indexPath.row]
        cell.setData(result)
        cell.category.text = viewModel.searchResultsbyMaterial.count.description
        if let imageURL = URL(string: result.photoURL) {
            cell.imageV.kf.setImage(with: imageURL)
        } else {
            cell.imageV.image = nil
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRecipe = viewModel.searchResults[indexPath.row]

        let detailRecipeVC = DetailRecipeVC()
        detailRecipeVC.recipe = selectedRecipe
        detailRecipeVC.detailId = indexPath.row
        let navigationController = UINavigationController(rootViewController: detailRecipeVC)
        navigationController.modalPresentationStyle = .fullScreen

        present(navigationController, animated: true, completion: nil)
    }
}
