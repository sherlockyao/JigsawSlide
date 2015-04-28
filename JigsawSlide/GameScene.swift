//
//  GameScene.swift
//  JigsawSlide
//
//  Created by Sherlock Yao on 4/23/15.
//  Copyright (c) 2015 Sherlock Yao. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var jigsawPanel: JigsawPanel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
  
    override init(size: CGSize) {
        super.init(size: size)
        backgroundColor = SKColor.whiteColor()
        jigsawPanel = JigsawPanel(pieces: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15])
        for node in createJigsawNodes() {
            addChild(node)
        }
    }
  
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
 
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func createJigsawNodes() -> [SKNode] {
        let xOffset: CGFloat = 60;
        let yOffset: CGFloat = 100;
        
        var nodes = [SKNode]()
        let texture = SKTexture(imageNamed: "MonkeyKing")
        let height = texture.size().height / 5.0
        let width = texture.size().width / 3.0
        for row in 0..<5 {
            for column in 0..<3 {
                let rect = CGRect(x: width * CGFloat(column), y: height * CGFloat(row), width: width, height: height)
                let node = SKSpriteNode(texture: SKTexture(regularRect: rect, inTexture: texture), size: CGSize(width: 80, height: 80))
                node.position = CGPoint(x: 80 * CGFloat(column) + xOffset, y: 80 * CGFloat(row) + yOffset)
                nodes.append(node)
            }
        }
        return nodes
    }
}
