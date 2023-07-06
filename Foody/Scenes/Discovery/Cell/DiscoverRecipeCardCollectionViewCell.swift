//
//  DiscoverRecipeCardCollectionViewCell.swift
//  Foody
//
//  Created by halil yılmaz on 8.06.2023.
//

import UIKit
import SnapKit

class DiscoverRecipeCardCollectionViewCell: UICollectionViewCell {
    static let identifier = "DiscoverRecipeCardCollectionViewCell"
    
    private let stackV: UIStackView = {
        let stackV = UIStackView()
        return stackV
    }()
    
    private let imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.clipsToBounds = true
        imageV.contentMode = .scaleToFill
        imageV.image = UIImage(named: ImageConstants.burger)
        return imageV
    }()
    
    private let lbl: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "DenemeXXX"
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func setupUI() {
        self.contentView.backgroundColor = .systemRed
        self.contentView.addSubview(stackV)
        stackV.addArrangedSubview(imageView)
        stackV.addArrangedSubview(lbl)
        
        
        stackV.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
        }
    }
    
    
}
