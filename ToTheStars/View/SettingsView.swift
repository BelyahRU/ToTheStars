//
//  SettingsView.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class SettingsView: UIView {
    
    //MARK: Views
    
    private let background = UIImageView(image: UIImage(named: "standartBackground"))
    private let grayRectangle = UIImageView(image: UIImage(named: "grayRectangle"))
    
    //MARK: Labels
    private let soundLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = LocalizationSystem.sharedInstance.getLanguage() == "en" ? "SOUND" : "ЗВУКИ"
        label.font = UIFont(name: Resources.Fonts.standartFont, size: 16)
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.4, height: 1.4)
        return label
    }()
    private let musicLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = LocalizationSystem.sharedInstance.getLanguage() == "en" ? "MUSIC" : "МУЗЫКА"
        label.font = UIFont(name: Resources.Fonts.standartFont, size: 16)
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.4, height: 1.4)
        return label
    }()
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = LocalizationSystem.sharedInstance.getLanguage() == "en" ? "LANGUAGE" : "ЯЗЫК"
        label.font = UIFont(name: Resources.Fonts.standartFont, size: 16)
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.4, height: 1.4)
        return label
    }()
    
    private let langSV: UIStackView = {
        let sv = UIStackView()
        sv.spacing = 13/320*UIScreen.main.bounds.width
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        return sv
    }()
    
    
    //MARK: Buttons
    public let musicButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "onButton"), for: .normal)
        return button
    }()
    public let soundButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "onButton"), for: .normal)
        return button
    }()
    public let RuButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "RuButton") : UIImage(named: "RuButtonBig"), for: .normal)
        return button
    }()
    public let EngButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "EngButton") : UIImage(named: "EngButtonBig"), for: .normal)
        return button
    }()
    
    //MARK: BackButton
    
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "backButtonEng") : UIImage(named: "backButtonRu"), for: .normal)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //320
    //568
    private func configure() {
        addSubview(background)
        addSubview(grayRectangle)
        addSubview(backButton)
        addSubview(soundLabel)
        addSubview(musicLabel)
        addSubview(languageLabel)
        addSubview(soundButton)
        addSubview(musicButton)
        addSubview(RuButton)
        addSubview(EngButton)
        
        
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
        
        soundLabel.snp.makeConstraints { make in
            make.top.equalTo(grayRectangle.snp.top).offset(39/568*UIScreen.main.bounds.height)
            make.leading.equalTo(grayRectangle.snp.leading).offset(57/568*UIScreen.main.bounds.height)
        }
        
        musicLabel.snp.makeConstraints { make in
            make.leading.equalTo(soundLabel.snp.leading)
            make.top.equalTo(grayRectangle.snp.top).offset(92/568*UIScreen.main.bounds.height)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalTo(grayRectangle.snp.top).offset(157/568*UIScreen.main.bounds.height)
            make.leading.equalTo(grayRectangle.snp.leading).offset(29/568*UIScreen.main.bounds.height)
        }
        
        soundButton.snp.makeConstraints { make in
            make.centerY.equalTo(soundLabel.snp.centerY)
            make.trailing.equalTo(grayRectangle.snp.trailing).inset(57/568*UIScreen.main.bounds.height)
        }
        
        musicButton.snp.makeConstraints { make in
            make.centerY.equalTo(musicLabel.snp.centerY)
            make.trailing.equalTo(grayRectangle.snp.trailing).inset(57/568*UIScreen.main.bounds.height)
        }
        
        RuButton.snp.makeConstraints { make in
            if LocalizationSystem.sharedInstance.getLanguage() == "en" {
                make.width.equalTo(44)
                make.height.equalTo(42)
            } else {
                make.width.equalTo(53)
                make.height.equalTo(50.5)
            }
            make.centerY.equalTo(languageLabel.snp.centerY)
            make.leading.equalTo(languageLabel.snp.trailing).offset(50)
        }
        
        EngButton.snp.makeConstraints { make in
            if LocalizationSystem.sharedInstance.getLanguage() == "en" {
                make.width.equalTo(53)
                make.height.equalTo(50.5)
            } else {
                make.width.equalTo(44)
                make.height.equalTo(42)
            }
            make.centerY.equalTo(languageLabel.snp.centerY)
            make.leading.equalTo(RuButton.snp.trailing).offset(13/320*UIScreen.main.bounds.width)
        }
        
        [EngButton, RuButton].forEach {
            $0.snp.makeConstraints { make in
                if LocalizationSystem.sharedInstance.getLanguage() == "en" {
                    
                }
            }
        }
        
        
        
        
    }
}
