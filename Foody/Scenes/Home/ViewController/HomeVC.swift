//
//  HomeViewController.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit

class HomeViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    var viewModel: HomeViewModel {
        .init()
    }
    
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
        self.tvMain.reloadData()
        setupUI()
        registerCell()
        
        let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem = share

    }
    
    @objc func shareTapped(){
        AuthService.shared.logOut { [weak self] error in
            guard self != nil else {
                return
            }
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    let splashScreenViewController = LoginViewController()
                    let newNavigationController = UINavigationController(rootViewController: splashScreenViewController)
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let sceneDelegate = windowScene.delegate as? SceneDelegate {
                        sceneDelegate.window?.rootViewController = newNavigationController
                    }
                }
            }
            

        }
        
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCardTableViewCell.identifier, for: indexPath) as! RecipeCardTableViewCell
        cell.selectionStyle = .none
//        cell.delegateShare = self
        cell.delegateLike = self
     
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRecipe = indexPath.row
//        let VC = DetailRecipeVC()
//        vc.detailId = selectedRecipe
        let detailRecipeVC = DetailRecipeVC()

        let navigationController = UINavigationController(rootViewController: detailRecipeVC)
        navigationController.modalPresentationStyle = .fullScreen

        // Present the navigationController
        present(navigationController, animated: true, completion: nil)

    }
    
}

//extension HomeViewController: RecipeCardTableViewCellShareDelegate {
//    func didTapShareButton() {
//        print("share tapped")
//        
//    }
//}
extension HomeViewController: RecipeCardTableViewCellLikeDelegate {
    func didTapLikeButton() {
        print("like tapped")
    }
}





//extension HomeViewController: RecipeCardTableViewCellDelegate {
//    func didTapCardDetail() {
//        print("tapped")
//    }
//}


