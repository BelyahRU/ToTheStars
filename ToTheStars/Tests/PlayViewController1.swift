//
//  PlayViewController.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let countdownLabel = UILabel()
    let rocketImageView = UIImageView()
    let backgroundImageView = UIImageView()
    
    var countdownTimer: Timer?
    var countdownSeconds = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupRocket()
        setupCountdownLabel()
        
        startCountdown()
    }
    
    func setupBackground() {
        backgroundImageView.image = UIImage(named: "background")
        backgroundImageView.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView)
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupRocket() {
        rocketImageView.image = UIImage(named: "rocketPhase1")
        rocketImageView.contentMode = .scaleAspectFit
        view.addSubview(rocketImageView)
        
        rocketImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(100)
            make.height.equalTo(200)
        }
    }
    
    func setupCountdownLabel() {
        countdownLabel.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        countdownLabel.textColor = .white
        countdownLabel.textAlignment = .center
        view.addSubview(countdownLabel)
        
        countdownLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func startCountdown() {
        countdownLabel.text = "\(countdownSeconds)"
        countdownTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    @objc func updateCountdown() {
        countdownSeconds -= 1
        countdownLabel.text = "\(countdownSeconds)"
        
        if countdownSeconds == 0 {
            countdownTimer?.invalidate()
            animateBackground()
        }
    }
    
    func animateBackground() {
        UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: {
            self.backgroundImageView.frame.origin.y -= self.view.frame.height
        }, completion: nil)
    }
}
