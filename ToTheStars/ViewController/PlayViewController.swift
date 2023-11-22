//
//  PlayViewController.swift
//  ToTheStars
//
//  Created by Александр Андреев on 09.08.2023.
//

import UIKit
import SpriteKit

class PlayViewController: UIViewController {
    public var playView = PlayView()
    //таймер для обратного отчета
    private let timerDuration = 3
    private var timer: Timer?
    private var remainingTime = 0
    
    //анимация ракеты
    private var rocketImageView: UIImageView!
    private var animationTimer: Timer?
    private var currentPhaseIndex = 0
    
    
    private var rightButton = UIButton()
    private var leftButton = UIButton()
    
    //фазы ракеты
    private let launchPhases = [
        UIImage(named: "rocketPhase1"),
        UIImage(named: "rocketPhase2"),
        UIImage(named: "rocketPhase3"),
        UIImage(named: "rocketPhase4"),
        UIImage(named: "rocketPhase5"),
        UIImage(named: "rocketPhase6"),
    ]
    
    var rocket: SKSpriteNode!

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.addSubview(playView)
        playView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        startRocket()
        startMoving()
    }
    
}

//MARK: обратный отчет
private extension PlayViewController {
    private func startRocket() {
        // Начало обратного отсчета таймера
        remainingTime = timerDuration
        playView.timerLabel.text = "\(remainingTime)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func updateTimer() {
        if remainingTime > 1 {
            remainingTime -= 1
            playView.timerLabel.text = "\(remainingTime)"
        } else {
            timer?.invalidate()
            self.playView.timerLabel.text = "START"
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.playView.timerLabel.text = ""
                self.start()
                UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseInOut, animations: {
                    self.playView.scrollView.contentOffset = CGPoint(x: 0, y: 0)
                }, completion: nil)

            }
        }
        
    }
}

//MARK: взлет и анимация ракеты
private extension PlayViewController {
    private func start() {
        rocketImageView = self.playView.rocketImageView
        rocketImageView.image = nil
        // Создаем UIImageView для ракеты с начальным изображением
        let initialRocketImage = launchPhases.first!
        rocketImageView = UIImageView(image: initialRocketImage)
        rocketImageView.contentMode = .scaleAspectFit
        view.addSubview(rocketImageView)
        //анимация изменения ракеты
        animationTimer = Timer.scheduledTimer(timeInterval: 0.2,
                                              target: self,
                                              selector: #selector(animateRocket),
                                              userInfo: nil,
                                              repeats: true)
        // обновление позиции ракеты
        rocketImageView.frame.origin.x = view.bounds.midX - rocketImageView.frame.width / 2
        rocketImageView.frame.origin.y = view.bounds.height-250
    }

    @objc func animateRocket() {
        // Проверим, если все фазы анимации прошли, остановим таймер
        if currentPhaseIndex == launchPhases.count {
            animationTimer?.invalidate()
            return
        }
        
        // Обновим изображение для текущей фазы анимации
        switch launchPhases[currentPhaseIndex] {
        case UIImage(named: "rocketPhase1"):
            rocketImageView.frame.size = CGSize(width: 104, height: 160)
        case UIImage(named: "rocketPhase2"):
            rocketImageView.frame.size = CGSize(width: 104, height: 198)
        case UIImage(named: "rocketPhase3"):
            rocketImageView.frame.size = CGSize(width: 104, height: 249)
        case UIImage(named: "rocketPhase4"):
            rocketImageView.frame.size = CGSize(width: 104, height: 174)
        default:
            rocketImageView.frame.size = CGSize(width: 104, height: 95)
        }
        rocketImageView.image = launchPhases[currentPhaseIndex]
        
        //обновляем индекс
        currentPhaseIndex += 1
        
        //обновляем местоположение ракеты
        rocketImageView.frame.origin.x = view.bounds.midX - rocketImageView.frame.width / 2
        rocketImageView.frame.origin.y = view.bounds.height-250
    }
}


//MARK: движение раветы
private extension PlayViewController {
    private func startMoving() {
        let scene = SKScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        let rocketImage = SKTexture(imageNamed: "rocketPhase6")
        // Создаем спрайт на основе изображения
        let rocketSize = rocketImage.size()
        // Задайте желаемый размер спрайта ракеты
        rocket = SKSpriteNode(texture: rocketImage, size: rocketSize)
        rocket.position = CGPoint(x: scene.size.width / 2, y: 200)
        scene.addChild(rocket)
        scene.backgroundColor = .clear
        
        // Создаем SKView и добавляем сцену
        let skView = SKView(frame: view.bounds)
        skView.presentScene(scene)
        skView.backgroundColor = .clear
        playView.scrollView.addSubview(skView)
        skView.snp.makeConstraints { make in
        make.top.leading.trailing.width.equalToSuperview()
        make.bottom.equalToSuperview().inset(UIScreen.main.bounds.height)
           }

        rightButton = playView.rightButton
        leftButton = playView.leftButton
        
        rightButton.addTarget(self, action: #selector(moveRocketRight), for: .touchUpInside)
        leftButton.addTarget(self, action: #selector(moveRocketLeft), for: .touchUpInside)
    }
    
    
    @objc func moveRocketLeft() {
        let action = SKAction.moveBy(x: -50, y: 0, duration: 0.5)
        rocket.run(action)

    }
    
    @objc func moveRocketRight() {
        let action = SKAction.moveBy(x: +50, y: 0, duration: 0.5)
        rocket.run(action)

    }
}
