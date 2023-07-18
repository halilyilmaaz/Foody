//
//  ProfilImageTableViewCell.swift
//  Foody
//
//  Created by halil yılmaz on 6.06.2023.
//

import UIKit

extension ProfilImageTableViewCellProtocol{
    func didTapFollowButton(){}
    func didTapAddButton(){}
    func didTapUnfollowButton(){}
}

protocol ProfilImageTableViewCellProtocol: AnyObject {
//    func didTapPickerButton()
    func didTapFollowButton()
    func didTapUnfollowButton()
    func didTapAddButton()
}

class ProfilImageTableViewCell: UITableViewCell {

    static let identifier = "ProfilImageTableViewCell"
    
    weak var delegate: ProfilImageTableViewCellProtocol?
    
//    let container: UIView = {
//        let view = UIButton()
//        view.backgroundColor = .clear
//        return view
//    }()
    
//    let pickerBtn: UIButton = {
//        let size:CGFloat = 60
//        let btn = UIButton()
//        btn.clipsToBounds = true
//        btn.bounds = CGRect(x: 0, y: 0, width: size, height: size)
//        btn.layer.cornerRadius = size / 2
//        return btn
//    }()
//
//    let imageV: UIImageView = {
//        let size:CGFloat = 76
//        let img = UIImageView()
//        img.clipsToBounds = true
//        img.backgroundColor = .gray
//        img.bounds = CGRect(x: 0, y: 0, width: size, height: size)
//        img.layer.cornerRadius = size / 2
//        img.layer.borderWidth = 1
//        img.layer.borderColor = UIColor.gray.cgColor
//        return img
//    }()
    
    let userName: UILabel = {
        let name = UILabel()
        name.numberOfLines = 1
        name.text = "@halilyilmaz"
        return name
    }()
    
    let infoContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
//        view.layer.borderWidth = 0.2
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let followBtn = CustomButton(title: "Takip Et", fontSize: .med, backgroundColor: .systemBlue)
    let addRecipeBtn = CustomButton(title: "Tarif Ekle", fontSize: .med, backgroundColor: .systemOrange)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
//        contentView.addSubview(container)
//        container.addSubview(imageV)
//        container.addSubview(pickerBtn)
        contentView.addSubview(userName)
        contentView.addSubview(infoContainer)
//        infoContainer.addSubview(followBtn)
        infoContainer.addSubview(addRecipeBtn)
        
        
//        container.snp.makeConstraints { make in
//            make.top.leading.equalToSuperview().offset(10)
//            make.bottom.equalToSuperview().offset(-10)
//            make.height.width.equalTo(96)
//        }
        
//        imageV.snp.makeConstraints { make in
//            make.top.leading.equalToSuperview().offset(10)
//            make.bottom.trailing.equalToSuperview().offset(-10)
//            make.height.width.equalTo(76)
//        }
//
//        pickerBtn.snp.makeConstraints { make in
//            make.top.leading.equalToSuperview().offset(10)
//            make.bottom.trailing.equalToSuperview().offset(-10)
//            make.height.width.equalTo(56)
//        }
        
//        userName.snp.makeConstraints { make in
//            make.top.equalTo(container.snp.bottom).offset(5)
//            make.bottom.equalToSuperview().offset(-5)
//            make.leading.equalToSuperview().offset(5)
//            make.trailing.equalToSuperview()
//            make.height.equalTo(10)
//        }
        
        infoContainer.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
//        followBtn.snp.makeConstraints { make in
//            make.top.leading.equalToSuperview().offset(20)
//            make.bottom.trailing.equalToSuperview().offset(-20)
//            make.height.equalTo(46)
//        }
        
        addRecipeBtn.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(10)
            make.height.equalTo(46)
        }
        

//        pickerBtn.addTarget(self, action: #selector(didTapPickerBtn), for: .touchUpInside)
//        followBtn.addTarget(self, action: #selector(didTapFollowBtb), for: .touchUpInside)
        addRecipeBtn.addTarget(self, action: #selector(didTapAddBtn), for: .touchUpInside)
    }
    
//    @objc func didTapPickerBtn() {
//        self.delegate?.didTapPickerButton()
//    }
    
//    @objc func didTapFollowBtb() {
//        followBtn.isSelected.toggle()
//
//        if followBtn.isSelected {
//            followBtn.backgroundColor = .secondarySystemBackground
//            followBtn.setTitleColor(.black, for: .normal)
//            followBtn.setTitle("Takipten çıkar", for: .normal)
//            self.delegate?.didTapFollowButton()
//        } else {
//            followBtn.backgroundColor = .systemBlue
//            followBtn.setTitleColor(.white, for: .normal)
//            followBtn.setTitle("Takip et", for: .normal)
//            self.delegate?.didTapUnfollowButton()
//        }
//    }
    
    @objc func didTapAddBtn(){
        self.delegate?.didTapAddButton()
    }
    
    func setData(_ model: RecipeCardModel){
        
    }

}
