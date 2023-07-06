//
//  ProfilSearchCardCell.swift
//  Foody
//
//  Created by halil yılmaz on 24.06.2023.
//

import UIKit

class ProfilSearchCardCell: UITableViewCell {
    
    static let identifier = "ProfilSearchCardCell"

    let view: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.2
        view.layer.cornerRadius = 6
        return view
    }()
    
    let circleAvatar: UIImageView = {
        let size:CGFloat = 46.0
        let img = UIImageView()
        img.clipsToBounds = true // Köşeleri kesmek için gerekli
        img.backgroundColor = .gray
        img.bounds = CGRect(x: 0, y: 0, width: size, height: size)
        img.layer.cornerRadius = size / 2
        img.layer.borderWidth = 1
        img.layer.borderColor = UIColor.gray.cgColor
        return img
    }()
    
    let title: UILabel = {
        let lbl = UILabel()
        lbl.text = "Halil Yılmaz"
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFont(ofSize: 16)
        return lbl
    }()
    
    let subTitle: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.text = "Some details about user, can we say bio"
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
        view.addSubview(circleAvatar)
        view.addSubview(title)
        view.addSubview(subTitle)
        
        view.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(6)
            make.bottom.trailing.equalToSuperview().offset(-5)
            make.height.equalTo(56)
        }
        
        circleAvatar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(46)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(circleAvatar.snp.trailing).offset(8)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(4)
            make.leading.equalTo(circleAvatar.snp.trailing).offset(8)
        }
        
    }

    func setData(_ model: DiscoveryService.User){
        title.text = model.username
        subTitle.text = model.email
    }
}
