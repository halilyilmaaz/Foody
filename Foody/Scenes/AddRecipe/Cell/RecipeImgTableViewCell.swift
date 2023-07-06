//
//  RecipeImgTableViewCell.swift
//  Foody
//
//  Created by halil yılmaz on 8.06.2023.
//

import UIKit
import SnapKit

protocol RecipeImgTableViewCellDelegate: AnyObject {
    func didTapSelectImage()
}

class RecipeImgTableViewCell: UITableViewCell {

    static let identifier = "RecipeImgTableViewCell"
    
    weak var delegate: RecipeImgTableViewCellDelegate?
    
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
    
    let selectImgBtn = UIButton()
    
    
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
        stackV.addSubview(selectImgBtn)
        
        stackV.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(10)
            make.bottom.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(500)
        }
        
        imageV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        selectImgBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        selectImgBtn.addTarget(self, action: #selector(didTapSelectImg), for: .touchUpInside)
    }
    
    @objc func didTapSelectImg(){
        self.delegate?.didTapSelectImage()
    }
}
