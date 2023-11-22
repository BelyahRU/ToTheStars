//
//  PlayView.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class PlayView: UIView {
    
    //MARK: ImageViews
    private let cosmosView = UIImageView(image: UIImage(named: "gameBackground"))
    private let background = UIImageView(image: UIImage(named: "background"))
    
    
    public var rocketImageView = UIImageView(image: UIImage(named: "rocketPhase1"))
    
    
    //MARK: Label
    public let timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.textAlignment = .center
        timerLabel.textColor = .red
        timerLabel.font = UIFont(name: Resources.Fonts.standartFont, size: 64)
        return timerLabel
    }()
    
    
    //MARK: ScrollView
    public lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        // Устанавливаем начальное смещение скролла внизу
        scrollView.setContentOffset(CGPoint(x: 0, y: UIScreen.main.bounds.height * 2), animated: false)
        // Размер экрана
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 2)
        return scrollView
    }()
    
    //MARK: Buttons
    public let leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "leftButton"), for: .normal)
        return button
    }()
    
    public let rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "rightButton"), for: .normal)
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
        addSubview(scrollView)
        
        scrollView.addSubview(background)
        scrollView.addSubview(timerLabel)
        scrollView.addSubview(rocketImageView)
        scrollView.addSubview(cosmosView)
        scrollView.addSubview(leftButton)
        scrollView.addSubview(rightButton)
        
        
        //MARK: Constraints
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        background.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        
        timerLabel.snp.makeConstraints { make in
            make.center.equalTo(background.snp.center)
            make.width.equalTo(300)
            make.height.equalTo(134)
        }
        rocketImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(50)
        }
        cosmosView.snp.makeConstraints { make in
            make.bottom.equalTo(background.snp.top)
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height)
        }
        
        leftButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15/320*UIScreen.main.bounds.width)
            make.bottom.equalTo(cosmosView.snp.bottom).inset(38/568*UIScreen.main.bounds.height)
            make.width.equalTo(53)
            make.height.equalTo(51)
        }
        
        rightButton.snp.makeConstraints { make in
            make.bottom.equalTo(cosmosView.snp.bottom).inset(38/568*UIScreen.main.bounds.height)
            make.trailing.equalTo(cosmosView).inset(15/320*UIScreen.main.bounds.width)

            
        }
    }
}
