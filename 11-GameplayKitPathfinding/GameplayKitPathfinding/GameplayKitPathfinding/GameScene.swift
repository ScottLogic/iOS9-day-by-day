//
//  GameScene.swift
//  GameplayKitPathfinding
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright (c) 2015 Shinobi Controls. All rights reserved.
//

import SpriteKit
import GameKit

class GameScene: SKScene {
    
    var moving:Bool = false
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        guard (!moving) else {return}

        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            self.movePlayerToLocation(location)
        }
    }
    
    func movePlayerToLocation(location: CGPoint) {
        moving = true
        
        let player = self.childNodeWithName("player")
        
        let obstacles = SKNode.obstaclesFromNodeBounds(self.children.filter({ (element ) -> Bool in
            return element != player
        }))
        
        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 10)
        
        let startNode = GKGraphNode2D(point: float2(Float(player!.position.x), Float(player!.position.y)))
        let endNode = GKGraphNode2D(point: float2(Float(location.x), Float(location.y)))
        
        graph.connectNodeUsingObstacles(startNode)
        graph.connectNodeUsingObstacles(endNode)
        
        let path:[GKGraphNode] = graph.findPathFromNode(startNode, toNode: endNode)
        
//        GKPath(graphNodes: <#T##[GKGraphNode2D]#>, radius: 10.0)
        
        guard path.count > 0 else { moving = false; return }
        
        var actions = [SKAction]()
        
        for node:GKGraphNode in path {
            if let point2d = node as? GKGraphNode2D {
                
                let point = CGPoint(x: CGFloat(point2d.position.x), y: CGFloat(point2d.position.y))
                
                print("estimated Cost \(startNode.estimatedCostToNode(point2d))")
                
                let action = SKAction.moveTo(point, duration: 1.0)
                actions.append(action)
            }
        }
        
        let sequence = SKAction.sequence(actions)
        player?.runAction(sequence, completion: { () -> Void in
            self.moving = false
        })
    }
}

