//
//  ProfilViewController.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit
import SnapKit
import Kingfisher


class ProfilViewController: UIViewController {
    var isFollowShow: Bool = true
    var viewModel = ProfileViewModel()
    var recipeRowCount: Int?
    var sections: [[ProfileSection]] {
        return [
            [.image],
            Array(repeating: .recipeList, count: recipeRowCount ?? viewModel.recipes.count).reversed()
        ]
    }

  
    private let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        return tv
    }()
    
    private let segmentControl: UISegmentedControl = {
        let segment = UISegmentedControl(items: ["bir", "iki"])
        segment.selectedSegmentIndex = 0
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        registerCells()
        tvMain.delegate = self
        tvMain.dataSource = self
        tvMain.reloadData()
        
        setupNavigationBar()
        
        viewModel.didUpdateUser = { [weak self] user in
            self?.updateUserProfile(user)
            self?.tvMain.reloadData()
        }
        viewModel.fetchUserProfil()
        

        viewModel.didUpdateRecipies = { [weak self] recipes, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self?.recipeRowCount = recipes?.count ?? 0
            self?.tvMain.reloadData()
        }
        
        viewModel.fetchRecipe()
       
    }

    
    func updateUserProfile(_ user: User?) {
        if let username = user?.username {
            self.navigationItem.title = username
        }
    }
    
    func setupNavigationBar() {
        if isFollowShow {
            let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill")?.withTintColor(.secondarySystemFill, renderingMode: .alwaysTemplate), style: .plain, target: self, action: #selector(settingsTapped))
            navigationItem.rightBarButtonItem = settingsButton
        }
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = isFollowShow ? nil : backButton
    }
    
    @objc func settingsTapped() {
        let detailRecipeVC = SettingsViewController()
        let navigationController = UINavigationController(rootViewController: detailRecipeVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
    func setupUI() {
        view.addSubview(tvMain)
        tvMain.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func registerCells() {
        tvMain.register(ProfilImageTableViewCell.self, forCellReuseIdentifier: ProfilImageTableViewCell.identifier)
        tvMain.register(RecipeCardTableViewCell.self, forCellReuseIdentifier: RecipeCardTableViewCell.identifier)
    }
}

extension ProfilViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionId = sections[indexPath.section][indexPath.row]
        
        switch sectionId {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfilImageTableViewCell.identifier, for: indexPath) as! ProfilImageTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            cell.addRecipeBtn.isHidden = !isFollowShow
            cell.followBtn.isHidden = isFollowShow
            cell.pickerBtn.isHidden = !isFollowShow
            return cell
        case .recipeList:
                let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCardTableViewCell.identifier, for: indexPath) as! RecipeCardTableViewCell
                cell.selectionStyle = .none
                cell.delegateLike = self

                let recipeIndex = indexPath.row
                let recipe: RecipeCardModel?
                

                if recipeIndex >= 0 && recipeIndex <= viewModel.recipes.count {
                    recipe = viewModel.recipes[recipeIndex]
                    cell.titleLbl.text = viewModel.recipes[recipeIndex].title
                    cell.howManyPerson = viewModel.recipes[recipeIndex].howManyPersonFor
                    cell.recipeTime = viewModel.recipes[recipeIndex].recipeTime
                    cell.materialsCount = viewModel.recipes[recipeIndex].materials.count
                    if let imageURL = URL(string: viewModel.recipes[recipeIndex].photoURL) {
                        cell.recipeImage.kf.setImage(with: imageURL)
                    } else {
                        cell.recipeImage.image = nil
                    }
                } else {
                    recipe = nil
                }
                return cell

        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionId = sections[indexPath.section][indexPath.row]
        
        switch sectionId {
        case .image:
            return
        case .recipeList:
            tableView.deselectRow(at: indexPath, animated: true)
            let recipeIndex = indexPath.row
            guard recipeIndex >= 0 && recipeIndex < viewModel.recipes.count else {
                return
            }
            
            let selectedRecipe = viewModel.recipes[recipeIndex]
            
            let detailRecipeVC = DetailRecipeVC()
            detailRecipeVC.recipe = selectedRecipe
            detailRecipeVC.detailId = indexPath.row
            let navigationController = UINavigationController(rootViewController: detailRecipeVC)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
        }
    }

}

extension ProfilViewController: ProfilImageTableViewCellProtocol {
    func didTapFollowButton() {
        print("follow")
        
    }
    
    func didTapUnfollowButton() {
        print("unfollow")
    }
    
    func didTapPickerButton() {
        print("Tappeedddd")
    }
    
    func didTapAddButton() {
        let detailRecipeVC = AddRecipeVC()
        let navigationController = UINavigationController(rootViewController: detailRecipeVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
}

extension ProfilViewController: RecipeCardTableViewCellLikeDelegate {
    func didTapLikeButton() {
        print("like tappped detail profile")
    }
}
