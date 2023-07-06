//
//  OnboardingView.swift
//  Foody
//
//  Created by halil yılmaz on 18.06.2023.
//

import UIKit
import SnapKit

protocol OnboardingViewDelegate: AnyObject {
    func didTapSkipButton()
    func didTapContinueButton()
    func didTapValueChanged()
    func didTapStartButton()
}

class OnboardingView: UIView {
    
    weak var delegate: OnboardingViewDelegate?
    
    //MARK: - Creating UI Elements
    private let emptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    let onboardingCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        return collectionView
    }()
    
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .systemGray
        return pageControl
    }()
    
    let contiuneButton = CustomButton(title: "Devam et", fontSize: .small, backgroundColor: .systemBlue)
    let startButton = CustomButton(title: "Hadi başlayalım 😊", fontSize: .small, backgroundColor: .systemBlue)
    
    let skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    
    //MARK: - Init Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - ConfigureView
    
    private func setupUI() {
        backgroundColor = .white
        
        addSubview(skipButton)
        addSubview(onboardingCollection)
        addSubview(pageControl)
        addSubview(contiuneButton)
        addSubview(startButton)
        
        skipButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(20)
        }
        
        onboardingCollection.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-150)
        }
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(onboardingCollection.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        pageControl.addTarget(self, action: #selector(didTapValueChange), for: .valueChanged)
        
        contiuneButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(46)
        }
        
        startButton.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            make.height.equalTo(46)
        }
        
        
        contiuneButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc func continueButtonTapped(){
        self.delegate?.didTapContinueButton()
    }
    
    @objc func skipButtonTapped(){
        self.delegate?.didTapSkipButton()
    }
    
    @objc func didTapValueChange(){
        self.delegate?.didTapValueChanged()
    }
    
    @objc func startButtonTapped(){
        self.delegate?.didTapStartButton()
    }
}
