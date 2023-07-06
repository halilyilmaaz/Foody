//
//  RegisterViewController.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit

class RegisterViewController: UIViewController {
    
    private let container = UIView()
    
    
    private let usernameTF = CustomTextField(fieldType: .username)
    private let emailTF = CustomTextField(fieldType: .email)
    
    private let passwordTF = CustomTextField(fieldType: .password)
    
    @objc func passwordVisibilityButtonTapped() {
        passwordTF.isSecureTextEntry.toggle()
    }
    
    private let registerBTN = CustomButton(title: "Üye Ol", fontSize: .med, backgroundColor: .systemBlue)
    
    
    private let signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Zaten hesabın var mı?"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Giriş Yap", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UINavigationBar.appearance().isHidden = true
        
        // Klavye açılışını dinlemek için NotificationCenter'a abone ol
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        // Klavye kapanışını dinlemek için NotificationCenter'a abone ol
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Görünümün üzerine UITapGestureRecognizer ekle
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        // Görünümü başlangıç pozisyonuna geri getir
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc private func dismissKeyboard() {
        // Görünümdeki tüm aktif textfield'ları bırak
        view.endEditing(true)
    }
    
    func setupUI(){
        view.addSubview(container)
        container.addSubview(usernameTF)
        container.addSubview(emailTF)
        container.addSubview(passwordTF)
        container.addSubview(registerBTN)
        
        container.addSubview(signUpStackView)
        signUpStackView.addArrangedSubview(loginLabel)
        signUpStackView.addArrangedSubview(loginButton)
        
        
        container.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-35)
            make.height.equalTo(300)
        }
        
        usernameTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        emailTF.snp.makeConstraints { make in
            make.top.equalTo(usernameTF.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(emailTF.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        registerBTN.snp.makeConstraints { make in
            make.top.equalTo(passwordTF.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(46)
        }
        
        registerBTN.addTarget(self, action: #selector(didTapRegisterBtn), for: .touchUpInside)
        
        signUpStackView.snp.makeConstraints { make in
            make.top.equalTo(registerBTN.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        loginLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        loginButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(loginLabel.snp.trailing).offset(10)
        }
        
        loginButton.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
        
    }
    
    @objc func didTapLoginBtn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapRegisterBtn() {
        let registerUserRequest = RegisterUser(
            username: self.usernameTF.text ?? "",
            email: self.emailTF.text ?? "",
            password: self.passwordTF.text ?? ""
        )
        
//        // Username check
//        if !Validator.isValidUsername(for: registerUserRequest.username) {
//            AlertManager.showInvalidUsernameAlert(on: self)
//            return
//        }
//
//        // Email check
//        if !Validator.isValidEmail(for: registerUserRequest.email) {
//            AlertManager.showInvalidEmailAlert(on: self)
//            return
//        }
//
//        // Password check
//        if !Validator.isPasswordValid(for: registerUserRequest.password) {
//            AlertManager.showInvalidPasswordAlert(on: self)
//            return
//        }
        
        AuthService.shared.register(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                print("1")
                return
            }
            
            if wasRegistered {
                self.navigationController?.popViewController(animated: true)
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
                print("3")
            }
        }
    }
    
}
