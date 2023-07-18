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
    
    var chipNames: [String] = [] {
        didSet {
            updateButtons()
        }
    }
    
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
        print("\(self.chipNames)----")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateButtons() {
        for button in buttons {
            button.removeFromSuperview()
        }
        
        buttons.removeAll()
        
        // Ensure that buttonCount does not exceed the number of elements in chipNames
        let validButtonCount = min(buttonCount, chipNames.count)
        
        for index in 0..<validButtonCount {
            let title = chipNames[index]
            let button = createButton(title: title)
            buttons.append(button)
            containerView.addSubview(button)
            
            button.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(index * 40)
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
                make.height.equalTo(36)
            }
        }
        
        containerView.snp.removeConstraints()
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
            make.height.equalTo(validButtonCount * 40)
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



