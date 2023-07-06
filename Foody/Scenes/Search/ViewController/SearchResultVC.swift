//
//  SearchResultVC.swift
//  Foody
//
//  Created by halil yılmaz on 24.06.2023.
//

import UIKit

class SearchResultVC: UIViewController {
    
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
    }
    
    func setupUI() {
        view.addSubview(tvMain)
        
        tvMain.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func registerCell() {
        tvMain.register(RecipeCardSearchCell.self, forCellReuseIdentifier: RecipeCardSearchCell.identifier)
    }
    
}

extension SearchResultVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCardSearchCell.identifier, for: indexPath) as! RecipeCardSearchCell
        return cell
        
    }
    
    // TODO: tıklandığında muhtemelen detay sayfasına gidecek.
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedRecipe = indexPath.row
        let detailRecipeVC = DetailRecipeVC()
        let navigationController = UINavigationController(rootViewController: detailRecipeVC)
        navigationController.modalPresentationStyle = .fullScreen

        // Present the navigationController
        present(navigationController, animated: true, completion: nil)

    }
    
}
