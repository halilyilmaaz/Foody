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
    
    var howManyPerson: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.howManyPersonLbl.iconAndLabel(icon: "person.fill", label: "\(self.howManyPerson) kişilik")
            }
        }
    }
    var recipeTime: Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.cookingTimeLbl.iconAndLabel(icon: "clock.fill", label: "\(self.recipeTime) dk hazırlık")
            }
        }
    }
    
    var materialsCount: Int = 0 {
        didSet {
            self.howManyMaterialsLbl.iconAndLabel(icon: "clock.fill", label: "Malzemeler \(materialsCount)")
        }
    }

    private let stackV: UIStackView = {
        let stackV = UIStackView()
        //stackV.axis = .vertical
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
        view.layer.borderWidth = 0.5
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
    
    let howManyPersonLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
    
    
    let cookingTimeLbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textColor = .white
        lbl.font = .systemFont(ofSize: 12, weight: .regular)
        return lbl
    }()
    
    let howManyMaterialsLbl: UILabel = {
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
        bottomContainer.addSubview(howManyPersonLbl)
        bottomContainer.addSubview(cookingTimeLbl)
        bottomContainer.addSubview(howManyMaterialsLbl)
        
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
        
        howManyPersonLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
        }
        
        cookingTimeLbl.snp.makeConstraints { make in
            make.top.equalTo(howManyPersonLbl.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
        }
        
        howManyMaterialsLbl.snp.makeConstraints { make in
            make.top.equalTo(cookingTimeLbl.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(10)
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
