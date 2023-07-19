//
//  CustomIcon.swift
//  Foody
//
//  Created by halil yılmaz on 19.07.2023.
//

import Foundation
import UIKit

class CustomIcon: UIImageView {
    init(title: String, size: CGFloat, color: UIColor) {
        super.init(frame: .zero)
        self.image = UIImageHelper.createIcon(title: title, size: size, color: color)
        self.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class UIImageHelper {
    static func createIcon(title: String, size: CGFloat, color: UIColor) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(pointSize: size, weight: .medium)
        let image = UIImage(systemName: title, withConfiguration: configuration)
        
        guard let coloredImage = image?.withTintColor(color, renderingMode: .alwaysOriginal) else {
            return nil
        }
        
        return coloredImage
    }
}
