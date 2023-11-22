//
//  GameOverViewController.swift
//  ToTheStars
//
//  Created by Александр Андреев on 11.08.2023.
//

import UIKit

class GameOverViewController: UIViewController {
    
    private let gameOverView = GameOverView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.addSubview(gameOverView)
        gameOverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gameOverView.playAgainButton.addTarget(self, action: #selector(playAgainPressed), for: .touchUpInside)
        gameOverView.menuButton.addTarget(self, action: #selector(menuPressed), for: .touchUpInside)
        gameOverView.countStarsLabel.text = ("\(AppDelegate.shared.currentScore)")
        AppDelegate.shared.currentScore = 0
        
    }
}

private extension GameOverViewController {
    @objc func playAgainPressed() {
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func menuPressed() {
        let vc = MenuViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
