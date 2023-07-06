//
//  PaddingTextField.swift
//  Foody
//
//  Created by halil yılmaz on 10.06.2023.
//

import UIKit

class PaddingTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initUI()
    }
    
    func initUI() {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.bounds.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
            
        let rightPaddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: self.bounds.size.height))
        self.rightView = rightPaddingView
        self.rightViewMode = .always
            
        self.layer.borderWidth = 0.1
        self.layer.cornerRadius = 6
        
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)

    }
    
}




