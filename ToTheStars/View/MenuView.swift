//
//  MenuView.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class MenuView: UIView {
    private let background = UIImageView(image: UIImage(named: "standartBackground.png"))
    
    public let boardButton: UIButton = {
        let button = UIButton()
        button.setImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "boardButtonEng"): UIImage(named: "boardButtonRu"), for: .normal)
        return button
    }()
    
    public let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "settingsButtonEng"): UIImage(named: "settingsButtonRu"), for: .normal)
        return button
    }()
    
    public let rulesButton: UIButton = {
        let button = UIButton()
        button.setImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "rulesButtonEng"): UIImage(named: "rulesButtonRu"), for: .normal)
        return button
    }()
    
    public let playButton: UIButton = {
        let button = UIButton()
        button.setImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "playButtonEng"): UIImage(named: "playButtonRu"), for: .normal)
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
        addSubview(boardButton)
        addSubview(settingsButton)
        addSubview(rulesButton)
        addSubview(playButton)
        
        
        //320
        //568
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        boardButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(22/320*UIScreen.main.bounds.width)
            make.top.equalToSuperview().offset(24/569*UIScreen.main.bounds.height)
        }
        settingsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10/320*UIScreen.main.bounds.width)
            make.top.equalTo(63/569*UIScreen.main.bounds.height)
        }
        rulesButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(131/320*UIScreen.main.bounds.width)
            make.top.equalTo(108/569*UIScreen.main.bounds.height)
        }
        playButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16/320*UIScreen.main.bounds.width)
            make.top.equalToSuperview().offset(193/569*UIScreen.main.bounds.height)
        }
    }

}
