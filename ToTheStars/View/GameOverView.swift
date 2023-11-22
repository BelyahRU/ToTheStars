//
//  GameOverView.swift
//  ToTheStars
//
//  Created by Александр Андреев on 11.08.2023.
//

import UIKit

class GameOverView: UIView {
    
    private let background = UIImageView(image: UIImage(named: "gameOverBackground"))
    private let grayRectangle = UIImageView(image: UIImage(named: "grayRectangle"))
    
    private let starsCaught = UIImageView(image: UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "en" ? "stars caught": "ПОЙМАНО ЗВЕЗД"))
    
    public let countStarsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.514, green: 0.127, blue: 0.65, alpha: 1)
        label.font = UIFont(name: Resources.Fonts.standartFont, size: 36)
        label.textAlignment = .center
        label.text = "5"
        return label
    }()
    
    public let playAgainButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "en" ? "playAgainButtonEng" : "playAgainButtonRu"), for: .normal)
        return button
    }()
    
    public let menuButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: LocalizationSystem.sharedInstance.getLanguage() == "en" ? "menuButtonEng" : "menuButtonRu"), for: .normal)
        return button
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
        addSubview(starsCaught)
        addSubview(playAgainButton)
        addSubview(menuButton)
        addSubview(countStarsLabel)
        
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
         
        grayRectangle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(133/568*UIScreen.main.bounds.height)
            make.width.equalTo(254/320*UIScreen.main.bounds.width)
            make.height.equalTo(247/568*UIScreen.main.bounds.height)
            make.centerX.equalToSuperview()
        }
        
        starsCaught.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(grayRectangle.snp.top).offset(23/568*UIScreen.main.bounds.height)
        }
        
        countStarsLabel.snp.makeConstraints { make in
            make.top.equalTo(grayRectangle.snp.top).offset(51/568*UIScreen.main.bounds.height)
            make.centerX.equalToSuperview()
        }
        
        playAgainButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(grayRectangle.snp.top).offset(110/568*UIScreen.main.bounds.height)
        }
        
        menuButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(grayRectangle.snp.top).offset(183/568*UIScreen.main.bounds.height)
        }
    }
    
}
