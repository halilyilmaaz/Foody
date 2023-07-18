//
//  DetailRecipeVC.swift
//  Foody
//
//  Created by halil yılmaz on 8.06.2023.
//

import UIKit
import SnapKit
import Firebase
import FirebaseAuth
import Kingfisher

class DetailRecipeVC: UIViewController {
    
    var viewModel: DetailViewModel = DetailViewModel()
    
    var recipe: HomeRecipeCardModel?
    var detailId: Int?
    
    var sections: [[DetailRecipeSection]] {
        return [
            [.image],
            [.materials],
            [.detail],
            [.delete]
        ]
    }
    
    private let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = false
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
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        
        let shareButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItem = shareButton
        
        navigationItem.title = recipe?.title
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func shareButtonTapped() {
        guard let img = UIImage(systemName: "bell"), let url = URL(string: "htts://www.google.com") else {
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [
            img,
            url
        ], applicationActivities: nil)
        
        present(shareSheetVC, animated: true)
    }
    
    
    func setupUI(){
        view.addSubview(tvMain)
        
        tvMain.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func registerCell(){
        tvMain.register(RecipeDetailImageTableViewCell.self, forCellReuseIdentifier: RecipeDetailImageTableViewCell.identifier)
        tvMain.register(MaterialChipCell.self, forCellReuseIdentifier: MaterialChipCell.identifier)
        tvMain.register(RecipeLetterTableViewCell.self, forCellReuseIdentifier: RecipeLetterTableViewCell.identifier)
        tvMain.register(RecipeDeleteBtnTableViewCell.self, forCellReuseIdentifier: RecipeDeleteBtnTableViewCell.identifier)
    }
    
    
}
extension DetailRecipeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionId = self.sections[indexPath.section][indexPath.row]
        switch sectionId {
        case .image:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDetailImageTableViewCell.identifier, for: indexPath) as! RecipeDetailImageTableViewCell
            cell.delegate = self
            
            if let photoURL = self.recipe?.photoURL, let imageURL = URL(string: photoURL) {
                cell.imageV.kf.setImage(with: imageURL)
            } else {
                cell.imageV.image = nil
            }
            
            return cell
        case .materials:
            let cell = tableView.dequeueReusableCell(withIdentifier: MaterialChipCell.identifier, for: indexPath) as! MaterialChipCell
            if let recipe = recipe {
                cell.buttonCount = recipe.materials.count
                cell.chipNames = recipe.materials
            }
            return cell
        case .detail:
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeLetterTableViewCell.identifier, for: indexPath) as! RecipeLetterTableViewCell
            cell.letterLbl.text = self.recipe?.description
            return cell
        case .delete:
            if let userUID = Auth.auth().currentUser?.uid, let detailId = detailId {
                let db = Firestore.firestore()
                let recipeRef = db.collection("recipies").document(userUID).collection(userUID).document("\(detailId)")
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: RecipeDeleteBtnTableViewCell.identifier, for: indexPath) as? RecipeDeleteBtnTableViewCell {
                    cell.delegate = self
                    return cell
                }
            }
            return UITableViewCell()
        }
    }
}


extension DetailRecipeVC: RecipeDetailImageTableViewCellDelegate {
    func didTapLikeButton() {
        print("like tapped")
    }
}

extension DetailRecipeVC: RecipeDeleteBtnTableViewCellProtocol {
    func didTapDeleteRecipeButton() {
        AlertManager.showAlertWithTwoButton(on: self, title: "Sil", message: "Silmek istediğinizden emin misiniz?", button1Text: "Vazgeç", button2Text: "Sil") {
            self.navigationController?.popToRootViewController(animated: true)
        } button2Action: { [weak self] in
//            guard let recipeID = self?.recipe?.id else { return }
//            
//            self?.viewModel.didDelete = { [weak self] success, error in
//                if success {
//                    print("Tarif başarıyla silindi")
//                    // Silme işlemi başarılı olduğunda yapılacak işlemleri burada gerçekleştirebilirsiniz.
//                    // Örneğin, silme işlemi başarılıysa, kullanıcıyı başka bir ekrana yönlendirebilirsiniz.
//                    self?.navigationController?.popToRootViewController(animated: true)
//                } else if let error = error {
//                    print("Silme işlemi başarısız: \(error.localizedDescription)")
//                    // Silme işlemi sırasında bir hata oluştuysa burada kullanıcıya hata mesajı gösterebilirsiniz.
//                }
//            }
//            
//            // Silme işlemini başlatın
//            self?.viewModel.deleteRecipe(recipeID: recipeID)
        }
    }
}

