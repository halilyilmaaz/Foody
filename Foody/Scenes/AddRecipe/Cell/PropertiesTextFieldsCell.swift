//
//  PropertiesTextFields.swift
//  Foody
//
//  Created by halil yılmaz on 8.06.2023.
//

import UIKit
import SnapKit

class PropertiesTextFieldsCell: UITableViewCell {
    
    static let identifier = "PropertiesTFs"
    
    var nameTextFieldDelegate: UITextFieldDelegate?
    var recipeTextFieldDelegate: UITextFieldDelegate?
    var recipeTimeTextFieldDelegate: UITextFieldDelegate?
    var preparationTimeTextFieldDelegate: UITextFieldDelegate?
    var howManyPersonTextFieldDelegate: UITextFieldDelegate?
    
    
    var nameTextField: PaddingTextField = {
        let tf = PaddingTextField()
        tf.placeholder = "recipe name"
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 0.3
        tf.layer.cornerRadius = 6
        return tf
    }()
    var recipeTextField: PaddingTextField = {
        let tf = PaddingTextField()
        tf.placeholder = "recipe detail"
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 0.3
        tf.layer.cornerRadius = 6
        return tf
    }()
    var recipeTimeTextField: PaddingTextField = {
        let tf = PaddingTextField()
        tf.placeholder = "recipe time"
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 0.3
        tf.layer.cornerRadius = 6
        return tf
    }()
//    var preparationTimeTextField: PaddingTextField = {
//        let tf = PaddingTextField()
//        tf.placeholder = "time"
//        tf.layer.borderColor = UIColor.gray.cgColor
//        tf.layer.borderWidth = 0.3
//        tf.layer.cornerRadius = 6
//        return tf
//    }()
    var howManyPersonTextField: PaddingTextField = {
        let tf = PaddingTextField()
        tf.placeholder = "how many person for"
        tf.layer.borderColor = UIColor.gray.cgColor
        tf.layer.borderWidth = 0.3
        tf.layer.cornerRadius = 6
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        recipeTextField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI(){
        contentView.addSubview(nameTextField)
        contentView.addSubview(recipeTextField)
        contentView.addSubview(recipeTimeTextField)
//        contentView.addSubview(preparationTimeTextField)
        contentView.addSubview(howManyPersonTextField)
        
        nameTextField.delegate = nameTextFieldDelegate
        recipeTextField.delegate = recipeTextFieldDelegate
        recipeTimeTextField.delegate = recipeTimeTextFieldDelegate
//        preparationTimeTextField.delegate = preparationTimeTextFieldDelegate
        howManyPersonTextField.delegate = howManyPersonTextFieldDelegate
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        recipeTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        recipeTimeTextField.snp.makeConstraints { make in
            make.top.equalTo(recipeTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
//        preparationTimeTextField.snp.makeConstraints { make in
//            make.top.equalTo(recipeTimeTextField.snp.bottom).offset(10)
//            make.leading.equalToSuperview().offset(10)
//            make.trailing.equalToSuperview().offset(-10)
//            make.height.equalTo(40)
//        }
        
        howManyPersonTextField.snp.makeConstraints { make in
            make.top.equalTo(recipeTimeTextField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(40)
        }
    }
    
    func getTexts() -> (name: String?, recipe: String?, recipeTime: Int?, howManyPerson: Int?) {
        let name = nameTextField.text
        let recipe = recipeTextField.text
        let recipeTime = Int(recipeTimeTextField.text ?? "")
//        let preparationTime = preparationTimeTextField.text
        let howManyPerson = Int(howManyPersonTextField.text ?? "")
        return (name, recipe, recipeTime, howManyPerson)
    }
}

extension PropertiesTextFieldsCell: UITextFieldDelegate {
    
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //
    //        if textField == recipeTextField {
    //               // Girilen metnin boyutunu al
    //               let currentText = textField.text ?? ""
    //               let updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
    //
    //               // Text boyutunu yeniden hesapla ve uygula
    //               let newSize = updatedText.size(withAttributes: [.font: textField.font as Any])
    //               let maxHeight: CGFloat = 200 // İsteğe bağlı olarak maksimum yüksekliği ayarlayın
    //               let newHeight = min(maxHeight, newSize.height) // Maksimum yükseklik sınırını uygula
    //
    //               textField.snp.updateConstraints { make in
    //                   make.height.equalTo(newHeight) // Yeni yüksekliği güncelle
    //               }
    //
    //               UIView.animate(withDuration: 0.2) {
    //                   self.layoutIfNeeded() // Animasyonlu bir şekilde hücrenin boyutunu güncelle
    //               }
    //           }
    //
    //           return true
    //    }
    
}
