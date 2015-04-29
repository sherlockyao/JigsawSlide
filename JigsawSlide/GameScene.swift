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
    var touchLocation: CGPoint?
    
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
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if 1 < touches.count {
            return
        }
        let touch = touches.first as! UITouch
        touchLocation = touch.locationInNode(self)
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let startLocation = touchLocation {
            let touch = touches.first as! UITouch
            let endLocation = touch.locationInNode(self)
            let dx = endLocation.x - startLocation.x
            let dy = endLocation.y - startLocation.y
            // seems the coordinate is different from Sprit Kit system
            if fabs(dy) < fabs(dx) {
                tryPanelMove((0 < dx) ? .Left : .Right)
            } else {
                tryPanelMove((0 < dy) ? .Down : .Up)
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
    
    private func createJigsawNodes() -> [SKNode] {
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
    
    private func tryPanelMove(move: JigsawMove) {
        let (resultPanel, success) = jigsawPanel.makeMove(move)
        if success {
            let node = nodeAtPosition(resultPanel.slotPosition)
            let point = pointOfPosition(jigsawPanel.slotPosition)
            let action = SKAction.moveTo(point, duration: 0.2)
            node.runAction(action)
            jigsawPanel = resultPanel
        }
    }
    
    private func nodeAtPosition(position: (Int, Int)) -> SKNode {
        return nodeAtPoint(pointOfPosition(position))
    }
    
    private func pointOfPosition(position: (Int, Int)) -> CGPoint {
        let x = CGFloat(80 * position.1 + 60)
        let y = CGFloat(80 * (position.0 - 1) + 100)
        return CGPoint(x: x, y: y)
    }
}
