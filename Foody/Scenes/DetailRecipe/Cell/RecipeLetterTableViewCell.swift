//
//  RecipeLetterTableViewCell.swift
//  Foody
//
//  Created by halil yılmaz on 9.06.2023.
//

import UIKit
import SnapKit



class RecipeLetterTableViewCell: UITableViewCell {

    static let identifier = "RecipeLetterTableViewCell"
    
    var letterLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        contentView.addSubview(letterLbl)
        

        letterLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
}

