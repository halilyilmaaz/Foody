//
//  MaterialListCell.swift
//  Foody
//
//  Created by halil yılmaz on 25.06.2023.
//

import UIKit
import SnapKit

class MaterialListCell: UITableViewCell {
    static let identifier = "MaterialsListCell"
    
    let view: UIView = {
        let view = UIView()
        return view
    }()
    
    let sectionLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.tintColor = .black
        lbl.font = UIFont.systemFont(ofSize: 18)
        return lbl
    }()
    
    let rowLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 1
        lbl.font = UIFont.systemFont(ofSize: 10)
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
        view.addSubview(sectionLabel)
        view.addSubview(rowLabel)
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        sectionLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(64)
        }
        
        rowLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.height.equalTo(46)
        }
    }
}
