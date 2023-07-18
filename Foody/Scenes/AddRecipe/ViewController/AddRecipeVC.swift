//
//  AddRecipeVC.swift
//  Foody
//
//  Created by halil yılmaz on 8.06.2023.
//

import UIKit
import SnapKit

class AddRecipeVC: UIViewController {
    
    var sections: [[AddRecipeSection]] {
        return [
            [.image],
            [.tfs],
            [.confirmBtn]
        ]
    }
    
    var selectedMaterials: [String] = []
        
    private var recipeName: String?
    private var recipeDetail: String?
    private var recipeTime: Int?
    private var preparationTime: String?
    private var howManyPersonFor: Int?
    
    private var nameTextField: UITextField?
    private var recipeTextField: UITextField?
    private var recipeTimeTextField: UITextField?
    private var preparationTimeTextField: UITextField?
    private var howManyPersonTextField: UITextField?
    
    
    var viewModel: AddRecipeViewModel = {
        .init()
    }()
    
    var materialViewModel: MaterialSelectionPresentVM = {
        .init()
    }()
    
    private let tvMain: UITableView = {
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = false
        return tv
    }()
    
    
    private let addButton: UIButton = {
        let btn = UIButton()
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "AddRecipe Screen"
        tvMain.delegate = self
        tvMain.dataSource = self
        tvMain.reloadData()
        
        setupUI()
        registerCell()
        keyboardSettings()
        setupNavigationBar()
        print("\(materialViewModel.selectedItems.description) *-*-*-*-*-*-*-*-*-*-*-*-*-")
    }
    
    func setupNavigationBar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = "Tarif Ekle"
    }
    
    @objc func backButtonTapped() {
        dismiss(animated: true)
    }
    
    func keyboardSettings(){
        // Klavye açılışını dinlemek için NotificationCenter'a abone ol
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
         // Klavye kapanışını dinlemek için NotificationCenter'a abone ol
         NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Görünümün üzerine UITapGestureRecognizer ekle
           let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           view.addGestureRecognizer(tapGesture)
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        // Görünümü başlangıç pozisyonuna geri getir
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        // Klavye yüksekliğini alma
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            // Görünümü klavye yüksekliği kadar yukarı kaydır
            UIView.animate(withDuration: 0.3) {
                self.view.frame.origin.y = -keyboardSize.height
            }
        }
    }
    
    @objc private func dismissKeyboard() {
        // Görünümdeki tüm aktif textfield'ları bırak
        view.endEditing(true)
    }
    
    func setupUI() {
        view.addSubview(tvMain)
        
        tvMain.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func registerCell() {
        tvMain.register(RecipeImgTableViewCell.self, forCellReuseIdentifier: RecipeImgTableViewCell.identifier)
        tvMain.register(PropertiesTextFieldsCell.self, forCellReuseIdentifier: PropertiesTextFieldsCell.identifier)
        tvMain.register(ConfirmButtonTableViewCell.self, forCellReuseIdentifier: ConfirmButtonTableViewCell.identifier)
        
    }

}


extension AddRecipeVC: UITableViewDelegate, UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeImgTableViewCell.identifier, for: indexPath)as! RecipeImgTableViewCell
            cell.delegate = self
            return cell
        case .tfs:
            let cell = tableView.dequeueReusableCell(withIdentifier: PropertiesTextFieldsCell.identifier, for: indexPath) as! PropertiesTextFieldsCell
            cell.delegate = self
            cell.delegate = self
            cell.nameTextFieldDelegate = self
            cell.recipeTextFieldDelegate = self
            cell.recipeTimeTextFieldDelegate = self
            cell.preparationTimeTextFieldDelegate = self
            cell.howManyPersonTextFieldDelegate = self
//            cell.materilasLbl.text = materialViewModel.selectedItems.description

            nameTextField = cell.nameTextField
            recipeTextField = cell.recipeTextField
            recipeTimeTextField = cell.recipeTimeTextField
            howManyPersonTextField = cell.howManyPersonTextField
            
            return cell
        case .confirmBtn:
            let cell = tableView.dequeueReusableCell(withIdentifier: ConfirmButtonTableViewCell.identifier, for: indexPath) as! ConfirmButtonTableViewCell
                    cell.delegate = self
                    return cell
        }
    }
}

extension AddRecipeVC: PropertiesTextFieldsCellProtocol {
    func didTapSelectMaterialButton() {
        let materialSelectionVC = MaterialSelectionPresentVC()
        materialSelectionVC.delegate = self
        present(materialSelectionVC, animated: true)
    }
}
extension AddRecipeVC: MaterialSelectionPresentVCDelegate {
    func didSelectMaterials(selectedItems: [String]) {
        print("\(selectedItems) ??????????")
        if let cell = tvMain.cellForRow(at: IndexPath(row: 0, section: 1)) as? PropertiesTextFieldsCell {
            cell.materilasLbl.text = selectedItems.joined(separator: ", ")
            self.selectedMaterials = selectedItems
        }
    }
}

extension AddRecipeVC: RecipeImgTableViewCellDelegate {
    func didTapSelectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
        
    }
}

extension AddRecipeVC: ConfirmButtonTableViewCellDelegate {
    func didTapConfirmButton() {
        print("ekleme fonk çalıştı")
        guard let name = nameTextField?.text,
              let recipe = recipeTextField?.text,
              let recipeTimeText = recipeTimeTextField?.text,
              let recipeTime = Int(recipeTimeText),
              let howManyPersonText = howManyPersonTextField?.text,
              let howManyPerson = Int(howManyPersonText) else {
            print("Geçerli değerler alınamadı")
            return
        }
        let createdAt = Date()
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        if let cell = tvMain.cellForRow(at: selectedIndexPath) as? RecipeImgTableViewCell {
            let photo = cell.imageV.image
            viewModel.addRecipe(photo: photo, title: name, subTitle: recipe, recipeTime: recipeTime, materials: selectedMaterials, howManyPersonFor: howManyPerson, createdAt: createdAt) { success, error in
                if let error = error {
                    print(error.localizedDescription)
                }
                if success {
                    print("Tarif başarıyla eklendi")
                    AlertManager.showAlertWithButton(on: self, title: "Başarıyla eklendi", message: "Lezzetli bir tarif eklendi :)", buttonText: "Tamam") {
                        let vc = TabBarController()
                        vc.dismiss(animated: true, completion: nil)
                    }
                } else {
                    print("Tarif eklenirken bir hata oluştu")
                }
            }
        }
    }
}



extension AddRecipeVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == nameTextField {
            recipeName = textField.text
        } else if textField == recipeTextField {
            recipeDetail = textField.text
        } else if textField == recipeTimeTextField {
            if let time = Int(textField.text ?? "") {
                recipeTime = time
            }
        } else if textField == preparationTimeTextField {
            preparationTime = textField.text
        } else if textField == howManyPersonTextField {
            if let personCount = Int(textField.text ?? "") {
                howManyPersonFor = personCount
            }
        }
    }
}



extension AddRecipeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            let selectedIndexPath = IndexPath(row: 0, section: 0)
            if let cell = tvMain.cellForRow(at: selectedIndexPath) as? RecipeImgTableViewCell {
                cell.imageV.image = editedImage
                
                // Seçilen fotoğrafı veritabanına kaydetmek için burada ilgili işlemleri yapabilirsiniz.
                // Örneğin, fotoğrafı bir veri olarak alıp Firebase'e kaydedebilirsiniz.
                // Kaydetme işlemlerini AddRecipeViewModel sınıfınıza taşıyabilirsiniz.
                // Bu noktada ihtiyaçlarınıza ve projenize uygun veritabanı entegrasyonunu yapmanız gerekecektir.
                
            }
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
