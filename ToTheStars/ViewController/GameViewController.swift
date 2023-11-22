//
//  GameViewController.swift
//  ToTheStars
//
//  Created by Демид Стариков on 10.08.2023.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    private var scene: GameScene!
    
    override func viewWillAppear(_ animated: Bool) {
        setupScene()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupScene() {
      view = SKView(frame: view.bounds)
      let skView = view as! SKView
        skView.showsNodeCount = false
      scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .resizeFill
      skView.presentScene(scene)
    }

}
