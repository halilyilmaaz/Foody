//
//  ConfirmButtonTableViewCell.swift
//  Foody
//
//  Created by halil yılmaz on 8.06.2023.
//

import UIKit
import SnapKit

protocol ConfirmButtonTableViewCellDelegate: AnyObject {
    func didTapConfirmButton()
}

class ConfirmButtonTableViewCell: UITableViewCell {
    
    static let identifier = "ConfirmButtonTableViewCell"
    
    weak var delegate: ConfirmButtonTableViewCellDelegate?
    
    private let confirmButton = CustomButton(title: "Ekle", fontSize: .med, backgroundColor: .systemBlue)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(confirmButton)
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(46)
        }
        
        confirmButton.addTarget(self, action: #selector(didTapConfirmBtn), for: .touchUpInside)
    }
    
    @objc func didTapConfirmBtn() {
        self.delegate?.didTapConfirmButton()
    }
}
