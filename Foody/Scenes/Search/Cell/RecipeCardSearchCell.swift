//
//  RecipeCardSearchCell.swift
//  Foody
//
//  Created by halil yılmaz on 25.06.2023.
//

import UIKit

class RecipeCardSearchCell: UITableViewCell {

    static let identifier = "RecipeCardSearchCell"
    
    let view: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.2
        view.layer.cornerRadius = 6
        return view
    }()
    
    let imageV: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: ImageConstants.burger)
        img.layer.cornerRadius = 6
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let container: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 6
        view.backgroundColor = .gray.withAlphaComponent(0.6)
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "Some meal"
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let category: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "vegan"
        lbl.font = UIFont.systemFont(ofSize: 12)
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
        contentView.addSubview(view)
        view.addSubview(imageV)
        view.addSubview(container)
        container.addSubview(title)
        container.addSubview(category)
        
        view.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(6)
            make.bottom.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(150)
        }
        
        imageV.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.bottom.trailing.equalToSuperview()
            make.height.equalTo(150)
        }
        
        container.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(6)
            make.leading.equalToSuperview().offset(8)
        }
        
        category.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(8)
        }
        
        
    }

}
