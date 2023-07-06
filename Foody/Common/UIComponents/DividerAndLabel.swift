//
//  DividerAndLabel.swift
//  Foody
//
//  Created by halil yılmaz on 10.06.2023.
//

import UIKit

class DividerAndLabel: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initUI()
    }
    
    func initUI() {
        self.layer.borderWidth = 1
        self.layer.frame.size.height = frame.size.height / 2
    }
    
}
