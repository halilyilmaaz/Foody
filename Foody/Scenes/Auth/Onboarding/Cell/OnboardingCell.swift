//
//  OnboardingCell.swift
//  Foody
//
//  Created by halil yılmaz on 18.06.2023.
//

import UIKit
import Lottie

final class OnboardingCell: UICollectionViewCell {
    
    
    static let identifier = "OnboardingCell"
    
    //MARK: - Creating UI Elements
    
    var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
//    var onboardingImageView: LottieAnimationView = .init()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    var slideTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.text = "Title Label"
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    var slideSubtitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .darkGray
        label.text = "descdescdescdesc  descdescdescdesc"
        label.numberOfLines = 0
        return label
    }()
    
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureLottie()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - ConfigureCell
    
    private func configureCell() {
        isUserInteractionEnabled = false
        setupUI()
    }
    private func configureLottie(){
    }
        
    func setupUI(){
        addSubview(onboardingImageView)
        addSubview(labelStackView)
        addSubview(slideTitleLabel)
        addSubview(slideSubtitleLabel)
        
        onboardingImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(300)
        }

        slideTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(onboardingImageView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(40)
        }
        
        slideSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(slideTitleLabel.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(80)
        }
    }
    
    //MARK: - Configure
    
    func configure(_ data: OnboardingSlide) {
        onboardingImageView.image = data.image
        slideTitleLabel.text = data.title
        slideSubtitleLabel.text = data.subtitle
    }
    
}
