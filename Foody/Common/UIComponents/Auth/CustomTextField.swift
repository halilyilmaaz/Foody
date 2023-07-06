//
//  CustomTextField.swift
//  Foody
//
//  Created by halil yılmaz on 16.06.2023.
//

import UIKit

class CustomTextField: UITextField {
    
    enum CustomTextFieldType {
        case username
        case email
        case password
    }
    
    private let authFieldType: CustomTextFieldType
    
    private lazy var rightViewButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eye-icon"), for: .normal)
        button.addTarget(self, action: #selector(rightViewButtonTapped), for: .touchUpInside)
        return button
    }()
    
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        self.backgroundColor = .secondarySystemBackground
        self.layer.cornerRadius = 10
        
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        
        self.leftViewMode = .always
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.size.height))
        
        switch fieldType {
        case .username:
            self.placeholder = "Kullanıcı adı"
        case .email:
            self.placeholder = "Email"
            self.keyboardType = .emailAddress
            self.textContentType = .emailAddress
        case .password:
            self.placeholder = "Şifre"
            self.textContentType = .oneTimeCode
            self.isSecureTextEntry = true
            self.addRightViewButton(image: UIImage(systemName: "eye"))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func rightViewButtonTapped() {
        self.isSecureTextEntry.toggle()
        let imageName = self.isSecureTextEntry ? "eye" : "eye.slash"
        rightViewButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    private func addRightViewButton(image: UIImage?) {
        let rightViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: self.frame.size.height))
        rightViewButton.frame = rightViewContainer.bounds
        rightViewContainer.addSubview(rightViewButton)
        
        self.rightView = rightViewContainer
        self.rightViewMode = .always
    }
}
