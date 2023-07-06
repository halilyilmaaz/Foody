//
//  UILabel+Extensions.swift
//  Foody
//
//  Created by halil yılmaz on 11.06.2023.
//

import UIKit

extension UILabel {
    func iconAndLabel(icon: String, label: String){
        let iconImage = UIImage(systemName: icon)
        let iconImageView = UIImageView(image: iconImage)
        iconImageView.tintColor = .white
        let lbl = UILabel()
        lbl.text = label
        let stackView = UIStackView(arrangedSubviews: [iconImageView, lbl])
        stackView.axis = .horizontal
        stackView.spacing = 8
        addSubview(stackView)
        
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(16)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
