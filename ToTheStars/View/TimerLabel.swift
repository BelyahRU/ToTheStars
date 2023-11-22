//
//  TimerLabel.swift
//  ToTheStars
//
//  Created by Александр Андреев on 14.08.2023.
//
import UIKit

class TimerLabel: UILabel {
    var timeRemaining = 0
    var timer: Timer?
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "00:00"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startTimer() {
        timer?.invalidate() // Остановить таймер, если он уже запущен
        timeRemaining = 0 // Установить желаемое время в секундах
        updateTimerLabel()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        timeRemaining += 1
        updateTimerLabel()
    }
    
    func updateTimerLabel() {
        let minutes = timeRemaining / 60
        let seconds = timeRemaining % 60
        
        let minutesString = String(format: "%02d", minutes)
        let secondsString = String(format: "%02d", seconds)
        
        self.text = "\(minutesString):\(secondsString)"
    }
}
