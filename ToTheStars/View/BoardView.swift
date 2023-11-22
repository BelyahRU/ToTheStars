//
//  BoardView.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class BoardView: UIView {

    //MARK: Views
    private let background = UIImageView(image: UIImage(named: "standartBackground"))
    private let grayRectangle = UIImageView(image: UIImage(named: "grayRectangle"))
    
    //MARK: BackButton
    public let backButton: UIButton = {
        let button = UIButton()
        button.setImage(LocalizationSystem.sharedInstance.getLanguage() == "en" ? UIImage(named: "backButtonEng") : UIImage(named: "backButtonRu"), for: .normal)
        return button
    }()
    
    //MARK: TableView
    
    public let resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorColor = .black
        return tableView
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
        addSubview(resultsTableView)
        
        
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
        resultsTableView.snp.makeConstraints { make in
            make.leading.equalTo(grayRectangle.snp.leading).offset(14/320*UIScreen.main.bounds.width)
            make.trailing.equalTo(grayRectangle.snp.trailing).inset(14/320*UIScreen.main.bounds.width)
            make.top.equalTo(grayRectangle.snp.top)
            make.bottom.equalTo(backButton.snp.top)
        }

    }
}
