//
//  Menu.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit
import SnapKit


class MenuViewController: UIViewController {
    
    private let menuView = MenuView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.addSubview(menuView)
        
        menuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        menuView.boardButton.addTarget(self, action: #selector(boardPressed), for: .touchUpInside)
        menuView.playButton.addTarget(self, action: #selector(playPressed), for: .touchUpInside)
        menuView.rulesButton.addTarget(self, action: #selector(rulesPressed), for: .touchUpInside)
        menuView.settingsButton.addTarget(self, action: #selector(settingsPressed), for: .touchUpInside)
    }
}

private extension MenuViewController {
    @objc func boardPressed(){
        let vc = BoardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func playPressed(){
        let vc = GameViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func rulesPressed(){
        let vc = RulesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func settingsPressed(){
        let vc = SettingsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
