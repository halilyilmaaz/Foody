//
//  CustomButton.swift
//  Foody
//
//  Created by halil yılmaz on 19.07.2023.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    init(label: String, size: CGFloat, color: UIColor, weight: UIFont.Weight, numberOfLines: Int) {
        super.init(frame: .zero)
        self.text = label
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.textColor = color
        self.textAlignment = .center
        self.numberOfLines = numberOfLines
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
