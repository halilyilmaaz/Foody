//
//  IconWithLabel.swift
//  Foody
//
//  Created by halil yılmaz on 11.06.2023.
//

import UIKit

class IconWithLabel: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        initUI()
    }
    
    func initUI() {
        
        let icon = UIImage(systemName: "person.and.person")
        let label = UILabel()
        

    }
    
}
