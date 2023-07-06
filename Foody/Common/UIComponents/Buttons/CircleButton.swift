//
//  CircleButton.swift
//  Foody
//
//  Created by halil yılmaz on 18.06.2023.
//

import UIKit

final class CircleButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        configureButton()
    }
    
    private func configureButton() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
        layer.masksToBounds = true
    }

}
