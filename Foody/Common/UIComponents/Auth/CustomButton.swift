//
//  CustomButton.swift
//  Foody
//
//  Created by halil yılmaz on 16.06.2023.
//

import UIKit

class CustomButton: UIButton {
    
    enum FontSize {
        case big
        case med
        case small
    }
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize, cornerRadius: CGFloat = 12, backgroundColor: UIColor) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.backgroundColor = backgroundColor
        
        let titleColor: UIColor = .white
        self.setTitleColor(titleColor, for: .normal)
        
        switch fontSize {
        case .big:
            self.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .med:
            self.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            self.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
