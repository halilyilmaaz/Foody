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

    private let stackV: UIStackView = {
        let stackV = UIStackView()
        stackV.layer.cornerRadius = 6
        return stackV
    }()
    
    private let container: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.gray.cgColor
        return view
    }()
    
     let recipeImage: UIImageView = {
        let bImg = UIImageView()
        bImg.image = UIImage(named: ImageConstants.burger)
        bImg.layer.cornerRadius = 6
        bImg.contentMode = .scaleToFill
        bImg.clipsToBounds = true
        return bImg
    }()
    
    private let emptyCardView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let bottomContainer: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.3
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 6
        view.backgroundColor = .gray.withAlphaComponent(0.6)
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()

    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Title"
        lbl.font = UIFont(name: "Helvetica", size: 24)
        lbl.numberOfLines = 0
        lbl.textColor = .white
        return lbl
    }()
    
    // MARK: Row 1
    let row1: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let personIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "person.fill")
        return icon
    }()
    
    let personCount: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
    

    // MARK: Row 2
    let row2: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let clockIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "person.fill")
        return icon
    }()
    
    let timeValue: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
    
    
    // MARK: Row 3
    let row3: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        return view
    }()
    
    let materialsIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "person.fill")
        return icon
    }()
    
    let materialsCount: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
      
    
    private let likeButton: UIButton = {
        let btn = UIButton()
        btn.layer.borderWidth = 0.2
        btn.layer.cornerRadius = 6
        btn.backgroundColor = .lightGray.withAlphaComponent(0.6)
        btn.layer.borderColor = UIColor.gray.cgColor
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
        contentView.addSubview(container)
        container.isUserInteractionEnabled = true
        container.addSubview(stackV)
        stackV.addArrangedSubview(recipeImage)

        stackV.addArrangedSubview(bottomContainer)

        recipeImage.addSubview(emptyCardView)
        bottomContainer.addSubview(titleLbl)
        bottomContainer.addSubview(row1)
        bottomContainer.addSubview(row2)
        bottomContainer.addSubview(row3)
        
        row1.addSubview(personIcon)
        row1.addSubview(personCount)
        
        row2.addSubview(clockIcon)
        row2.addSubview(timeValue)
        
        row3.addSubview(materialsIcon)
        row3.addSubview(materialsCount)
        
        
        bottomContainer.addSubview(likeButton)
        
        container.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(350)
        }
        
        stackV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        recipeImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        emptyCardView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bottomContainer.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        row1.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(60)
        }
        
        personIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        
        personCount.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        
        
        row2.snp.makeConstraints { make in
            make.top.equalTo(row1.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(60)
        }
        
        clockIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        
        timeValue.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        row3.snp.makeConstraints { make in
            make.top.equalTo(row2.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(60)
        }
        
        materialsIcon.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview()
            make.width.equalTo(50)
        }
        
        materialsCount.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.height.equalTo(36)
        }
        
        likeButton.addTarget(self, action: #selector(didTapLikeBtn), for: .touchUpInside)
        
    }
    
    
    @objc func didTapLikeBtn() {
        self.delegateLike?.didTapLikeButton()
    }
    
}
