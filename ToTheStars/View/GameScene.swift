

import UIKit
import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    private var backgroundSpeed = 4
    private var game = false
    private var move = false
    private var gameTimer: Timer!
    
    var timerLabel: TimerLabel!


    
    private let rocket = SKSpriteNode(imageNamed: "rocketPhase1")
    private let leftArrow = SKSpriteNode(imageNamed: "leftButton")
    private let rightArrow = SKSpriteNode(imageNamed: "rightButton")
    
    
    
    private var animationTimer: Timer?
    private var currentPhaseIndex = 0
    private var direction: MoveDirection = .unowned
    
    private var asteroids = ["asteroid1", "asteroid2", "asteroid3"]
    
    //фазы ракеты
    private let launchPhases = [
        UIImage(named: "rocketPhase1"),
        UIImage(named: "rocketPhase2"),
        UIImage(named: "rocketPhase3"),
        UIImage(named: "rocketPhase4"),
        UIImage(named: "rocketPhase5"),
        UIImage(named: "rocketPhase6"),
    ]
    
    private let starCategory : UInt32 = 2
    private let asteroidCategory : UInt32 = 1
    private let rocketCategory : UInt32 = 0
    
    
    
    override func didMove(to view: SKView) {
        addPhysics()
        createGrounds()
        createStart()
        moveGrounds()
        createRocket()
        createNavigation()
        setupTimer()
        
    }
    func setupTimer() {
        timerLabel = TimerLabel()
        timerLabel.font = UIFont(name: Resources.Fonts.standartFont, size: 20)
        timerLabel.textAlignment = .center
        timerLabel.textColor = .white
        timerLabel.layer.cornerRadius = 14
        timerLabel.layer.borderWidth = 3
        timerLabel.layer.borderColor = UIColor(red: 0.58, green: 0.004, blue: 0.137, alpha: 1).cgColor
        view!.addSubview(timerLabel)
        timerLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(77)
            make.height.equalTo(30)
            
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveGrounds()
        if rocket.frame.maxX >= frame.maxX-25 || rocket.frame.minX <= frame.minX+25 {
            move = false
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody = contact.bodyA
        var secondBody: SKPhysicsBody = contact.bodyB
        
        if (firstBody.categoryBitMask == rocketCategory)
                    &&
                    (secondBody.categoryBitMask == asteroidCategory)
                    ||
                    (firstBody.categoryBitMask == asteroidCategory)
                    &&
                    (secondBody.categoryBitMask == rocketCategory)
        {
            gameOver()
        } else if (firstBody.categoryBitMask == asteroidCategory)
                    &&
                    (secondBody.categoryBitMask == starCategory)
                    
        {
            removeCollisionStar(star: secondBody.node as! SKSpriteNode)
        } else if (firstBody.categoryBitMask == starCategory)
                    &&
                    (secondBody.categoryBitMask == asteroidCategory)
        {
            removeCollisionStar(star: firstBody.node as! SKSpriteNode)
        } else if (firstBody.categoryBitMask == starCategory)
                    &&
                    (secondBody.categoryBitMask == rocketCategory)
        {
            addScore(star: firstBody.node as! SKSpriteNode)
        } else if (firstBody.categoryBitMask == rocketCategory)
                    &&
                    (secondBody.categoryBitMask == starCategory)
        {
            addScore(star: secondBody.node as! SKSpriteNode)
        }
    }
    
    private func removeCollisionStar(star: SKSpriteNode) {
        star.removeFromParent()
    }
    
    private func addScore(star: SKSpriteNode) {
        AppDelegate.shared.currentScore += 1
        if AppDelegate.shared.record < AppDelegate.shared.currentScore {
            AppDelegate.shared.record = AppDelegate.shared.currentScore
        }
        star.removeFromParent()
    }
    
    
    func gameOver() {
        // Остановите движение астероидов и ракеты
        self.isPaused = true
        move = false
        //game = false
        gameTimer.invalidate()
        timerLabel.timer?.invalidate()
        
        
        let vc = GameOverViewController()

        if let navigationController = self.view?.window?.rootViewController as? UINavigationController {
            navigationController.navigationBar.isHidden = true
            navigationController.pushViewController(vc, animated: true)
        }
    }

    
    private func createStart() {
        // Создаем узел для отображения текста
        let countdownLabel = SKLabelNode(fontNamed: Resources.Fonts.standartFont)
        countdownLabel.fontColor = .red
        countdownLabel.text = "3"
        countdownLabel.fontSize = 64
        countdownLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(countdownLabel)
        
        // Создаем анимацию появления текста
        let countdownAction = SKAction.sequence([
            SKAction.scale(to: 1, duration: 0.5),
            SKAction.wait(forDuration: 0.5),
            SKAction.run { [weak self] in
                countdownLabel.text = "2"
            },
            SKAction.scale(to: 1, duration: 0.5),
            SKAction.wait(forDuration: 0.5),
            SKAction.run { [weak self] in
                countdownLabel.text = "1"
            },
            SKAction.scale(to: 1, duration: 0.5),
            SKAction.wait(forDuration: 0.5),
            SKAction.run { [weak self] in
                countdownLabel.text = "Start"
            },
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.removeFromParent()
        ])
        
        // Запускаем анимацию появления текста
        countdownLabel.run(countdownAction)

    }
    
    @objc
    private func addStar() {
        if game {
            asteroids = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: asteroids) as! [String]
            
            let vrag = SKSpriteNode(imageNamed: "star")
            let randomPos = GKRandomDistribution(lowestValue: Int(frame.minX+25), highestValue: Int(frame.maxX-25))
            let pos = CGFloat(randomPos.nextInt())
            vrag.position = CGPoint(x: pos, y: 800)
            
            vrag.physicsBody = SKPhysicsBody(rectangleOf: vrag.size)
            vrag.physicsBody?.isDynamic = true
            
            vrag.physicsBody?.categoryBitMask = starCategory
            vrag.physicsBody?.contactTestBitMask = rocketCategory | asteroidCategory
            vrag.physicsBody?.collisionBitMask = 0
            
            
            self.addChild(vrag)
            
            let animDuration: TimeInterval = 6
            
            var actions = [SKAction]()
            if asteroids[0] == "asteroids1" {
                let a = Int.random(in: 0...1)
                if a == 1 {
                    actions.append(SKAction.move(to: CGPoint(x: pos+500, y: -1500), duration: 3))
                    actions.append(SKAction.removeFromParent())
                } else {
                    actions.append(SKAction.move(to: CGPoint(x: pos-500, y: -1500), duration: 3))
                    actions.append(SKAction.removeFromParent())
                }
            } else {
                actions.append(SKAction.move(to: CGPoint(x: pos, y: -700+200), duration: animDuration))
                actions.append(SKAction.removeFromParent())
            }
            
            vrag.run(SKAction.sequence(actions ))
        }
    }
    
    
    @objc
    private func addVrag() {
        if game {
            //print("asd")
            asteroids = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: asteroids) as! [String]
            
            let vrag = SKSpriteNode(imageNamed: asteroids[0])
            let randomPos = GKRandomDistribution(lowestValue: Int(frame.minX+25), highestValue: Int(frame.maxX-25))
            let pos = CGFloat(randomPos.nextInt())
            vrag.position = CGPoint(x: pos, y: 800)
            
            vrag.physicsBody = SKPhysicsBody(rectangleOf: vrag.size)
            vrag.physicsBody?.isDynamic = true
            
            vrag.physicsBody?.categoryBitMask = asteroidCategory
            vrag.physicsBody?.contactTestBitMask = starCategory | rocketCategory
            vrag.physicsBody?.collisionBitMask = 0
            
            
            self.addChild(vrag)
            
            let animDuration: TimeInterval = 6
            
            var actions = [SKAction]()
            if asteroids[0] == "asteroids1" {
                let a = Int.random(in: 0...1)
                if a == 1 {
                    actions.append(SKAction.move(to: CGPoint(x: pos+500, y: -1500), duration: 3))
                    actions.append(SKAction.removeFromParent())
                } else {
                    actions.append(SKAction.move(to: CGPoint(x: pos-500, y: -1500), duration: 3))
                    actions.append(SKAction.removeFromParent())
                }
            } else {
                actions.append(SKAction.move(to: CGPoint(x: pos, y: -700+200), duration: animDuration))
                actions.append(SKAction.removeFromParent())
            }
            
            vrag.run(SKAction.sequence(actions ))
        }
    }
    private func createNavigation() {
        leftArrow.name = "leftArrow"
        leftArrow.size = CGSize(width: leftArrow.size.width, height: leftArrow.size.height)
        leftArrow.position = CGPoint(x: frame.minX + 50, y: frame.minY + 70)
        leftArrow.isHidden = true
        self.addChild(leftArrow)
        
        rightArrow.name = "rightArrow"
        rightArrow.size = CGSize(width: rightArrow.size.width, height: rightArrow.size.height)
        rightArrow.position = CGPoint(x: frame.maxX - 50, y: frame.minY + 70)
        rightArrow.isHidden = true
        self.addChild(rightArrow)
    }
    
    private func createRocket() {
        rocket.name = "Rocket"
        
        
        rocket.size = CGSize(width: rocket.size.width, height: rocket.size.height)
        rocket.position = CGPoint(x: frame.width/2, y: frame.minY + 150)
        
        rocket.physicsBody = SKPhysicsBody(texture: rocket.texture!, size: CGSize(width: 60, height: 95.5))
        rocket.physicsBody?.categoryBitMask = rocketCategory
        rocket.physicsBody?.collisionBitMask = 0
        rocket.physicsBody?.contactTestBitMask = starCategory | asteroidCategory
        rocket.physicsBody?.usesPreciseCollisionDetection = true
        
        self.addChild(rocket)
        

        
    }
    
    private func rocketAnimation() {
        animationTimer = Timer.scheduledTimer(timeInterval: 0.2,
                                                          target: self,
                                                          selector: #selector(animateRocket),
                                                          userInfo: nil,
                                                          repeats: true)
    }
    

    
    @objc private func animateRocket() {
        if currentPhaseIndex == launchPhases.count {
            animationTimer?.invalidate()
            self.leftArrow.isHidden = false
            self.rightArrow.isHidden = false
            return
        }
        
        let rocketImage = SKTexture(image: launchPhases[currentPhaseIndex]!)
        let rocketSize = rocketImage.size()
        rocket.texture = SKTexture(image: launchPhases[currentPhaseIndex]!)
        rocket.size = rocketSize
        
        currentPhaseIndex += 1
        
        let seconds = 3.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        }
    }
    
    private func createGrounds() {
//        for i in 0...5 {
//            let background = SKSpriteNode(imageNamed: "dfasbdf")
//            background.name = "Background"
//            background.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!+200)
//            background.position = CGPoint(x: frame.midX, y: CGFloat(i)*background.size.height)
//            background.zPosition = -1
//            self.addChild(background)
//        }
//        let background1 = SKSpriteNode(imageNamed: "background")
//        background1.name = "Background1"
//        background1.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
//        background1.position = CGPoint(x: frame.midX, y: frame.midY)
//        background1.zPosition = -1
//        self.addChild(background1)
        let background1 = SKSpriteNode(imageNamed: "background")
            background1.name = "Background1"
            background1.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            background1.position = CGPoint(x: frame.midX, y: frame.midY)
            background1.zPosition = -1
            self.addChild(background1)
            
            for i in 0...5 {
                let background = SKSpriteNode(imageNamed: "dfasbdf")
                background.name = "Background"
                background.size = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!+200)
                background.position = CGPoint(x: frame.midX, y: background1.position.y + background1.size.height + 100 + CGFloat(i)*background.size.height)
                background.zPosition = -1
                self.addChild(background)
            }

    }
    
    private func moveGrounds() {
        if game {
            self.enumerateChildNodes(withName: "Background1", using: ({
                (node, error) in
                node.position.y -= CGFloat(self.backgroundSpeed)
            }))
            self.enumerateChildNodes(withName: "Background", using: ({
                (node, error) in
                node.position.y -= CGFloat(self.backgroundSpeed)
                if node.position.y < -((self.scene?.size.height)!) {
                    node.position.y += node.frame.height * 5
                }
            }))
            if move {
                if direction == .left {
                    self.enumerateChildNodes(withName: "Rocket", using: ({
                        (node, error) in
                        node.position.x -= 3
                    }))
                } else if direction == .right {
                    self.enumerateChildNodes(withName: "Rocket", using: ({
                        (node, error) in
                        node.position.x += 3
                    }))
                }
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if !game {
            timerLabel.startTimer()
            rocketAnimation()
            game = true
            gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addVrag), userInfo: nil, repeats: true)
            gameTimer = Timer.scheduledTimer(timeInterval: 0.75, target: self, selector: #selector(addStar), userInfo: nil, repeats: true)
        }
        let touch = touches.first
        if let location = touch?.location(in: self) {
            let nodesArray = self.nodes(at: location)
            
            if nodesArray.first?.name == "rightArrow" {
                move = true
                direction = .right
            } else if nodesArray.first?.name == "leftArrow" {
                move = true
                direction = .left
            }
        }
    }
    
    private func addPhysics() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        move = false
    }
}

enum MoveDirection {
    case left, right, top, unowned
}
