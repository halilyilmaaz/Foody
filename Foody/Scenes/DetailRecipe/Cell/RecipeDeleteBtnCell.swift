//
//  RecipeDeleteBtnCell.swift
//  Foody
//
//  Created by halil yılmaz on 5.07.2023.
//

import UIKit
import SnapKit

protocol RecipeDeleteBtnTableViewCellProtocol: AnyObject {
    func didTapDeleteRecipeButton()
}

class RecipeDeleteBtnTableViewCell: UITableViewCell {
    
    static let identifier = "RecipeDeleteBtnCell"
    
    weak var delegate: RecipeDeleteBtnTableViewCellProtocol?
    
    let btnDelete: UIButton = {
        let btn = UIButton()
        btn.setTitle("Tarifi Sil", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        contentView.addSubview(btnDelete)

        btnDelete.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        btnDelete.addTarget(self, action: #selector(didTapSettingsBtn), for: .touchUpInside)
    }
    
    @objc func didTapSettingsBtn(){
        self.delegate?.didTapDeleteRecipeButton()
    }

}
