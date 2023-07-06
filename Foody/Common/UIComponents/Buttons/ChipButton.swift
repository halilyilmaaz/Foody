//
//  ChipButton.swift
//  Foody
//
//  Created by halil yılmaz on 22.06.2023.
//

import UIKit
import SnapKit

class ChipButton: UIButton {
    
    let chipIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor.white
        return imageView
    }()
    
    let chipLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        return lbl
    }()
    
    init(chipIcon: String, chipLabel: String, cornerRadius: CGFloat = 12) {
        super.init(frame: .zero)
        self.setTitle(chipLabel, for: .normal)
        
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        
        let iconImage = UIImage(systemName: chipIcon)
        self.setImage(iconImage, for: .normal)
        
        self.backgroundColor = .systemBlue
        self.configuration?.cornerStyle = .capsule
        let titleColor: UIColor = .white
        self.setTitleColor(titleColor, for: .normal)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(chipIcon)
        addSubview(chipLabel)
        
        let stackView = UIStackView(arrangedSubviews: [chipIcon, chipLabel])
        stackView.alignment = .center
        addSubview(stackView)
        stackView.spacing = 5
        
        stackView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(3)
            make.bottom.trailing.equalToSuperview().offset(-3)
        }
    }
}

