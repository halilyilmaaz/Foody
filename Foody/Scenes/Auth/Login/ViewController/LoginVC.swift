//
//  LoginViewController.swift
//  Foody
//
//  Created by halil yılmaz on 5.06.2023.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
    
    private let container = UIView()
    
    private let row: UIView = {
        let row = UIView()
        row.layer.cornerRadius = 6
        return row
    }()
    
    private let usernameTF = CustomTextField(fieldType: .email)
    private let passwordTF = CustomTextField(fieldType: .password)
 
    
    @objc func showHideButtonTapped() {
        passwordTF.isSecureTextEntry.toggle()
    }
    
    
    @objc func didtapRightBtn(){
        print("tapped eye")
    }
    
    
    private let forgotPasswordButton = CustomButton(title: "Forgot Password?", fontSize: .small , backgroundColor: .systemBlue)
    private let logintBTN = CustomButton(title: "Giriş Yap", fontSize: .med, backgroundColor: .systemBlue)
    
    
    private let orLabel: UILabel = {
        let label = UILabel()
        label.text = "or"
        label.textAlignment = .center
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let appleButton = CustomSignInButton(type: .apple)
    let googleButton = CustomSignInButton(type: .google)
    
    private let signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    private let registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Hesabın yok mu?"
        label.textColor = .systemGray
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Üye Ol", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemFill
        usernameTF.delegate = self
        passwordTF.delegate = self

        view.backgroundColor = .systemBackground

        setupUI()
        keyboardConfigure()
        navBarConfigure()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    //MARK: navigation bar configure
    func navBarConfigure(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UINavigationBar.appearance().isHidden = true
    }
    //MARK: keyboard  configure
    func keyboardConfigure(){
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
        container.addSubview(passwordTF)
        container.addSubview(logintBTN)
        container.addSubview(orLabel)
        container.addSubview(appleButton)
        container.addSubview(googleButton)
        container.addSubview(signUpStackView)
        signUpStackView.addArrangedSubview(registerLabel)
        signUpStackView.addArrangedSubview(registerButton)

        container.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-70)
            make.height.equalTo(360)
        }

        usernameTF.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        passwordTF.snp.makeConstraints { make in
            make.top.equalTo(usernameTF.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        logintBTN.snp.makeConstraints { make in
            make.top.equalTo(passwordTF.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(46)
        }

        logintBTN.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)

        orLabel.snp.makeConstraints { make in
            make.top.equalTo(logintBTN.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }

        appleButton.snp.makeConstraints { make in
            make.top.equalTo(orLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(46)
        }

        googleButton.snp.makeConstraints { make in
            make.top.equalTo(appleButton.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(46)
        }

        signUpStackView.snp.makeConstraints { make in
            make.top.equalTo(googleButton.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }

        registerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }

        registerButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.leading.equalTo(registerLabel.snp.trailing).offset(10)
        }

        registerButton.addTarget(self, action: #selector(didTapRegisterBtn), for: .touchUpInside)

    }
    
    @objc func didTapLoginBtn() {
        let loginRequest = LoginUserModel(
            email: self.usernameTF.text ?? "",
            password: self.passwordTF.text ?? ""
        )
        
//        // Email check
//        if !Validator.isValidEmail(for: loginRequest.email) {
//            AlertManager.showInvalidEmailOrPasswordAlert(on: self)
//            return
//        }
//
//        // Password check
//        if !Validator.isPasswordValid(for: loginRequest.password) {
//            AlertManager.showInvalidEmailOrPasswordAlert(on: self)
//            return
//        }
        
        AuthService.shared.login(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
        //        let vc = TabBarController()
        //        vc.modalPresentationStyle = .fullScreen
        //        navigationController?.present(vc, animated: true)
    }
    
    @objc func didTapRegisterBtn(){
        print("tapped")
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // TextField'ın editing durumunu sonlandır
        textField.resignFirstResponder()
        return true
    }
    
}
