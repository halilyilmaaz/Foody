//
//  CustomSignInButton.swift
//  Foody
//
//  Created by halil yılmaz on 18.06.2023.
//

import Foundation
import UIKit
import SnapKit


enum SignInButtonType: String {
    case google = "Google"
    case apple = "Apple"
}

class CustomSignInButton: UIButton {
    
    //MARK: - Creating UI Elements
    private lazy var buttonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var signInLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        return lbl
    }()
    
    let view = UIView()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(type: SignInButtonType) {
        self.init(frame: .zero)
        switch type {
        case .google:
            buttonImageView.image = UIImage(named: ImageConstants.googleIcon)
            signInLabel.text = "Sign in with \(SignInButtonType.google.rawValue)"
        case .apple:
            buttonImageView.image = UIImage(systemName: "applelogo")?.withTintColor(.black, renderingMode: .alwaysOriginal)
            signInLabel.text = "Sign in with \(SignInButtonType.apple.rawValue)"
        }
    }
    
    private func setupViews() {
        layer.borderColor = UIColor.init(named: "6279E0")?.cgColor
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize.init(width: 3, height: 3)
        
        addSubview(view)
        view.addSubview(buttonImageView)
        view.addSubview(signInLabel)
        
        view.snp.makeConstraints { make in
               make.center.equalToSuperview()
               make.height.equalTo(40)
           }
           
           buttonImageView.snp.makeConstraints { make in
               make.centerY.equalToSuperview()
               make.leading.equalToSuperview().offset(10)
               make.width.height.equalTo(24)
           }
           
           signInLabel.snp.makeConstraints { make in
               make.centerY.equalToSuperview()
               make.leading.equalTo(buttonImageView.snp.trailing).offset(10)
               make.trailing.lessThanOrEqualToSuperview().offset(-10)
           }
        
        
    }
}
