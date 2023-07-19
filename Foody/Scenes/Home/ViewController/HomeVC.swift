//
//  HomeViewController.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var viewModel: HomeViewModel = HomeViewModel()
    
    
    private let tvMain: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .secondarySystemBackground
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        self.tvMain.delegate = self
        self.tvMain.dataSource = self
        setupUI()
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        viewModel.didFetchRecipies = { [weak self] recipes, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.viewModel.recipies = recipes ?? []
                self?.tvMain.reloadData()
            }
        }
        
        viewModel.fetchHomeRecipe()
    }
    
  
    
    
    func setupUI() {
        view.addSubview(tvMain)
        
        tvMain.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func registerCell() {
        tvMain.register(RecipeCardTableViewCell.self, forCellReuseIdentifier: RecipeCardTableViewCell.identifier)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.recipies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCardTableViewCell.identifier, for: indexPath) as! RecipeCardTableViewCell
        cell.selectionStyle = .none
        cell.delegateLike = self

        let recipe = viewModel.recipies[indexPath.row]
        cell.titleLabel.text = recipe.title
        cell.personCount.text = recipe.howManyPersonFor.description
        cell.clockCount.text = recipe.recipeTime.description
        cell.materialsCount.text = recipe.materials.count.description
        if let imageURL = URL(string: recipe.photoURL) {
            cell.imgView.kf.setImage(with: imageURL)
        } else {
            cell.imgView.image = nil
        }
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedRecipe = viewModel.recipies[indexPath.row]

        let detailRecipeVC = DetailRecipeVC()
        detailRecipeVC.recipe = selectedRecipe
        detailRecipeVC.detailId = indexPath.row
        let navigationController = UINavigationController(rootViewController: detailRecipeVC)
        navigationController.modalPresentationStyle = .fullScreen

        present(navigationController, animated: true, completion: nil)

    }
}

extension HomeViewController: RecipeCardTableViewCellLikeDelegate {
    func didTapLikeButton() {
        print("like tapped")
    }
}
