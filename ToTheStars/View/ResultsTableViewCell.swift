//
//  ResultsTableViewCell.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    static let reuseId = "ResultsTableViewCell"
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.standartFont, size: 14)
        label.textColor = .white
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.5, height: 1.5)
        return label
    }()
    public let score: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Resources.Fonts.standartFont, size: 14)
        label.textColor = .white
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 1.5, height: 1.5)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(score)
        backgroundColor = .clear
        
        nameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(14)
        }
        score.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
        }
    }
    
    public func configure(result: Result1) {
        self.nameLabel.text = result.name
        self.score.text = String(result.score)
    }
    
}
