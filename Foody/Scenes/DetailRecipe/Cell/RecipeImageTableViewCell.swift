//
//  RecipeImageTableViewCell.swift
//  Foody
//
//  Created by halil yılmaz on 9.06.2023.
//

import UIKit
import SnapKit

protocol RecipeDetailImageTableViewCellDelegate: AnyObject {
    func didTapLikeButton()
}

class RecipeDetailImageTableViewCell: UITableViewCell {

    static let identifier = "RecipeImageTableViewCell"
    
    weak var delegate : RecipeDetailImageTableViewCellDelegate?

    let stackV: UIStackView = {
        let stackV = UIStackView()
        stackV.axis = .vertical
        return stackV
    }()
    
    let imageV: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: ImageConstants.burger)
        img.backgroundColor = .secondarySystemBackground
        img.layer.cornerRadius = 20
        img.clipsToBounds = true
        img.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return img
    }()
    
    
    let btnLike: UIButton = {
        let btn = UIButton()
        btn.contentHorizontalAlignment = .right
        btn.contentVerticalAlignment = .bottom
        btn.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.gray, renderingMode: .alwaysOriginal), for: .normal)
        return btn
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        contentView.addSubview(stackV)
        stackV.addArrangedSubview(imageV)
        stackV.addArrangedSubview(btnLike)
        
        stackV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(500)
        }
        
        imageV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        btnLike.snp.makeConstraints { make in
            make.bottom.equalTo(imageV.snp.bottom).offset(-10)
            make.trailing.equalTo(imageV.snp.trailing).offset(-10)
            make.height.width.equalTo(32)
        }
        
        btnLike.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
    }
    
    @objc func didTapLikeButton(){
        self.delegate?.didTapLikeButton()
    }

}
