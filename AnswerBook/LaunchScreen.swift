//
//  LaunchScreen.swift
//  AnswerBook
//
//  Created by HellöM on 2020/3/9.
//  Copyright © 2020 HellöM. All rights reserved.
//

import UIKit
import SpriteKit

protocol LaunchScreenDelegate {
    
    func enterMain()
}

class LaunchScreen: UIViewController {

    var delegate: LaunchScreenDelegate?
    @IBOutlet weak var skView: SKView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        skView.backgroundColor = .clear
        skView.allowsTransparency = true
        let skScene = SKScene(size: skView.frame.size)
        skScene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        skScene.backgroundColor = UIColor.clear
        skScene.scaleMode = .aspectFill
        skView.presentScene(skScene)
        view.addSubview(skView)
        
        let labelNode = SKLabelNode(fontNamed: "PingFangTC-Medium")
        labelNode.text = "解答之星"
        labelNode.fontColor = .black
        labelNode.fontSize = 50
        labelNode.horizontalAlignmentMode = .center
        skScene.addChild(labelNode)
        
        let scaleUp = SKAction.scale(to: 1.2, duration: 0.5)
        let scaleDown = SKAction.scale(to: 1.0, duration: 0.5)
        let scaleDowdsfn = SKAction.fadeOut(withDuration: 3.5)
        
        let sequence = SKAction.sequence([scaleUp,scaleDown])
        let sequence1 = SKAction.sequence([scaleDowdsfn])
        labelNode.run(SKAction.repeatForever(sequence))
        labelNode.run(SKAction.repeatForever(sequence1))
        
        let _ = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(enterMain), userInfo: nil, repeats: false)
    }
    
    @objc
    func enterMain() {
        
        delegate?.enterMain()
    }
}
