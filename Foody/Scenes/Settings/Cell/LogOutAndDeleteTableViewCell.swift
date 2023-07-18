//
//  LogOutAndDeleteTableViewCell.swift
//  Foody
//
//  Created by halil yılmaz on 17.07.2023.
//
import UIKit
import SnapKit

protocol LogOutAndDeleteTableViewCellDelegate: AnyObject {
    func didTapLogOut()
    func didTapDeleteAccount()
}

class LogOutAndDeleteTableViewCell: UITableViewCell {
    
    static let identifier = "LogOutAndDeleteTableViewCell"
    
    weak var delegate: LogOutAndDeleteTableViewCellDelegate?
    
    let lbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let logOut: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Çıkış yap", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
    }()
    
    private let deleteAccount: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hesabı sil", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(lbl)
        contentView.addSubview(logOut)
        contentView.addSubview(deleteAccount)
        
        lbl.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(15)
        }
        
        logOut.snp.makeConstraints { make in
            make.top.equalTo(lbl.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        deleteAccount.snp.makeConstraints { make in
            make.top.equalTo(logOut.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview().inset(15)
        }
        
        logOut.addTarget(self, action: #selector(didTapLogOutBtn), for: .touchUpInside)
        deleteAccount.addTarget(self, action: #selector(didTapdeleteAccountBtn), for: .touchUpInside)
    }

    
    @objc func didTapLogOutBtn() {
        self.delegate?.didTapLogOut()
    }
    
    @objc func didTapdeleteAccountBtn() {
        self.delegate?.didTapDeleteAccount()
    }
}
