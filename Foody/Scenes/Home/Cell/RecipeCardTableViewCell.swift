//
//  RecipeCardTableViewCell.swift
//  Foody
//
//  Created by halil yılmaz on 7.06.2023.
//

import UIKit
import SnapKit

protocol RecipeCardTableViewCellDelegate: AnyObject {
    func didTapCardDetail()
}

protocol RecipeCardTableViewCellLikeDelegate: AnyObject {
    func didTapLikeButton()
}

class RecipeCardTableViewCell: UITableViewCell {

    static let identifier = "RecipeCardTableViewCell"
    
    weak var delegate: RecipeCardTableViewCellDelegate?
    weak var delegateLike: RecipeCardTableViewCellLikeDelegate?

    let container: UIView = {
        let cont = UIView()
        cont.backgroundColor = .white
        cont.layer.cornerRadius = 6
        cont.layer.borderWidth = 0.08
        cont.clipsToBounds = true
        return cont
    }()
    
//    let containerBtn: UIButton = {
//        let cont = UIButton()
//        cont.layer.cornerRadius = 6
//        cont.layer.borderWidth = 0.1
//        cont.clipsToBounds = true
//        return cont
//    }()
    
    let imgView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 6
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = .blue
        return img
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Title"
        lbl.font = UIFont(name: "Helvetica", size: 21)
        lbl.numberOfLines = 1
        lbl.textColor = .black
        return lbl
    }()
    
    let personIcon = CustomIcon(title: "person.fill", size: 14, color: .black)
    let personCount = CustomLabel(label: "2", size: 14, color: .black, weight: .medium, numberOfLines: 1)

    let clockIcon = CustomIcon(title: "clock.fill", size: 13, color: .black)
    let clockCount = CustomLabel(label: "45", size: 14, color: .black, weight: .medium, numberOfLines: 1)
    let clockLbl = CustomLabel(label: "dk pişirme", size: 14, color: .black, weight: .medium, numberOfLines: 1)
    
    
    let materialsIcon = CustomIcon(title: "list.bullet.rectangle.fill", size: 12, color: .black)
    let materialsCount = CustomLabel(label: "3", size: 14, color: .black, weight: .medium, numberOfLines: 1)
    let materialsLbl = CustomLabel(label: "malzeme", size: 14, color: .black, weight: .medium, numberOfLines: 1)
    
    let likeButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 0.1
        btn.layer.cornerRadius = 4
        btn.backgroundColor = .white.withAlphaComponent(0.9)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.setImage(UIImage(systemName: "suit.heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
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
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(container)
        contentView.addSubview(likeButton)
        container.addSubview(imgView)
        container.addSubview(titleLabel)
        
        container.addSubview(personIcon)
        container.addSubview(personCount)
        
        container.addSubview(clockIcon)
        container.addSubview(clockCount)
        container.addSubview(clockLbl)
        
        container.addSubview(materialsIcon)
        container.addSubview(materialsCount)
        container.addSubview(materialsLbl)
        
        
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-4)
            make.height.equalTo(250)
        }
        
        
        imgView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        // MARK: person
        personIcon.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        personCount.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(personIcon.snp.trailing).offset(2)
            make.width.equalTo(20)
        }

        // MARK: clock
        clockIcon.snp.makeConstraints { make in
            make.top.equalTo(personIcon.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(16)
        }
        clockCount.snp.makeConstraints { make in
            make.top.equalTo(personIcon.snp.bottom).offset(2)
            make.leading.equalTo(clockIcon.snp.trailing).offset(2)
            make.width.equalTo(20)
        }
        clockLbl.snp.makeConstraints { make in
            make.top.equalTo(personIcon.snp.bottom).offset(2)
            make.leading.equalTo(clockCount.snp.trailing).offset(4)
        }

        // MARK: materials
        materialsIcon.snp.makeConstraints { make in
            make.top.equalTo(clockIcon.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-6)
        }
        materialsCount.snp.makeConstraints { make in
            make.top.equalTo(clockIcon.snp.bottom).offset(2)
            make.leading.equalTo(materialsIcon.snp.trailing).offset(2)
            make.bottom.equalToSuperview().offset(-6)
            make.width.equalTo(20)
        }
        materialsLbl.snp.makeConstraints { make in
            make.top.equalTo(clockIcon.snp.bottom).offset(2)
            make.leading.equalTo(materialsCount.snp.trailing).offset(4)
            make.bottom.equalToSuperview().offset(-6)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-22)
            make.height.equalTo(20)
        }
        
        likeButton.addTarget(self, action: #selector(didTapLikeBtn), for: .touchUpInside)
        
    }
    
    
    @objc func didTapLikeBtn() {
        self.delegateLike?.didTapLikeButton()
    }
    
}
