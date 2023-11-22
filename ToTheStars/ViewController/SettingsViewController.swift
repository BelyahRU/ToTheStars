//
//  SettingsViewController.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let settingsView = SettingsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        // Do any additional setup after loading the view.
    }
    private func configure() {
        view.addSubview(settingsView)
        
        settingsView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        settingsView.EngButton.addTarget(self, action: #selector(engPressed), for: .touchUpInside)
        settingsView.RuButton.addTarget(self, action: #selector(ruPressed), for: .touchUpInside)
        settingsView.soundButton.addTarget(self, action: #selector(soundPressed), for: .touchUpInside)
        settingsView.musicButton.addTarget(self, action: #selector(musicPressed), for: .touchUpInside)
        settingsView.backButton.addTarget(self, action: #selector(backPressed), for: .touchUpInside)
    }

    

}


private extension SettingsViewController {
    @objc func engPressed() {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
        restartApp()
    }
    @objc func ruPressed() {
        LocalizationSystem.sharedInstance.setLanguage(languageCode: "ru")
        restartApp()
    }
    @objc func soundPressed() {
        if settingsView.soundButton.currentImage == UIImage(named: "onButton") {
            settingsView.soundButton.setImage(UIImage(named: "offButton"), for: .normal)
        } else {
            settingsView.soundButton.setImage(UIImage(named: "onButton"), for: .normal)
        }
    }
    @objc func musicPressed() {
        if settingsView.musicButton.currentImage == UIImage(named: "onButton") {
            settingsView.musicButton.setImage(UIImage(named: "offButton"), for: .normal)
        } else {
            settingsView.musicButton.setImage(UIImage(named: "onButton"), for: .normal)
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    private func restartApp() {
        let alert = UIAlertController(title: nil, message: LocalizationSystem.sharedInstance.getLanguage() == "en" ? "Need to reopen app for update language" : "Необходимо повторно открыть приложение для обновления языка" , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: LocalizationSystem.sharedInstance.getLanguage() == "en" ? "Okay" : "Хорошо", style: .default, handler: { action in
          exit(0);
        }))
        self.present(alert, animated: true, completion: nil)
      }
    
}
