//
//  MaterialChipCell.swift
//  Foody
//
//  Created by halil yılmaz on 22.06.2023.
//

import UIKit
import SnapKit

class MaterialChipCell: UITableViewCell {
    
    static let identifier = "MaterialChipCell"
    
    var chipNames: [String] = []
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var buttonCount: Int = 0 {
        didSet {
            updateButtons()
        }
    }
    
    var buttons: [UIButton] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        updateButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateButtons() {
        for button in buttons {
            button.removeFromSuperview()
        }
        
        buttons.removeAll()
        
        for index in 0..<buttonCount {
            let button = createButton(title: "\(self.chipNames)")
            buttons.append(button)
            containerView.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(index * 40)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalTo(36)
            }
        }
        
        // Önceki yükseklik kısıtlamasını kaldır
        containerView.snp.removeConstraints()
        
        // Yeni yükseklik kısıtını ekle
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
            make.height.equalTo(buttonCount * 40)
        }
    }

    
    private func createButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemOrange.withAlphaComponent(0.4)
        button.setTitleColor(.darkGray, for: .normal)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        return button
    }
}



