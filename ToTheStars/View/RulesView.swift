//
//  RulesView.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class RulesView: UIView {
    
    //MARK: Views
    private let background = UIImageView(image: UIImage(named: "standartBackground"))
    private let grayRectangle = UIImageView(image: UIImage(named: "grayRectangle"))
    
    //MARK: BackButton
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "backButtonEng") : UIImage(named: "backButtonRu"), for: .normal)
        return button
    }()
    
    //MARK: Label
    
    public let rulesLabel: UILabel = {
        let label = UILabel()
        label.text = LocalizationSystem.sharedInstance.getLanguage() == "en" ? "Fly around asteroids and collect stars!" : "Облетай астероиды и собери звезды!"
        label.font = UIFont(name: Resources.Fonts.standartFont, size: 32)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.4, height: 1.4)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(background)
        addSubview(grayRectangle)
        addSubview(backButton)
        addSubview(rulesLabel)
        
        
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
         
        grayRectangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33/568*UIScreen.main.bounds.height)
            make.width.equalTo(254/320*UIScreen.main.bounds.width)
            make.height.equalTo(247/568*UIScreen.main.bounds.height)
            make.centerX.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.centerX.equalTo(grayRectangle.snp.centerX)
            make.centerY.equalTo(grayRectangle.snp.bottom)
        }
        
        rulesLabel.snp.makeConstraints { make in
            make.center.equalTo(grayRectangle.snp.center)
            make.width.equalTo(170/320*UIScreen.main.bounds.width)
            make.height.equalTo(180/568*UIScreen.main.bounds.height)
        }
    }
}
