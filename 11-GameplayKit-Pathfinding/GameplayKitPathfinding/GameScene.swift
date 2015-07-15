//
//  GameScene.swift
//  GameplayKitPathfinding
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright (c) 2015 Shinobi Controls. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var moving:Bool = false
    
    // Whenever a tap is detected, move the player to that position.
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = (touch as! UITouch).locationInNode(self)
            self.movePlayerToLocation(location)
        }
    }
    
    /// Moves the Player sprite through the scene to the given point, avoiding obstacles on the way.
    func movePlayerToLocation(location: CGPoint) {
        
        // Ensure the player doesn't move when they are already moving.
        guard (!moving) else {return}
        moving = true
        
        // Find the player in the scene.
        let player = self.childNodeWithName("player")
        
        // Create an array of obstacles, which is every child node, apart from the player node.
        let obstacles = SKNode.obstaclesFromNodeBounds(self.children.filter({ (element ) -> Bool in
            return element != player
        }))
        
        // Assemble a graph based on the obstacles. Provide a buffer radius so there is a bit of space between the
        // center of the player node and the edges of the obstacles.
        let graph = GKObstacleGraph(obstacles: obstacles, bufferRadius: 10)
        
        // Create a node for the user's current position, and the user's destination.
        let startNode = GKGraphNode2D(point: float2(Float(player!.position.x), Float(player!.position.y)))
        let endNode = GKGraphNode2D(point: float2(Float(location.x), Float(location.y)))
        
        // Connect the two nodes just created to graph.
        graph.connectNodeUsingObstacles(startNode)
        graph.connectNodeUsingObstacles(endNode)
        
        // Find a path from the start node to the end node using the graph.
        let path:[GKGraphNode] = graph.findPathFromNode(startNode, toNode: endNode)
        
        // If the path has 0 nodes, then a path could not be found, so return.
        guard path.count > 0 else { moving = false; return }
        
        // Create an array of actions that the player node can use to follow the path.
        var actions = [SKAction]()
        
        for node:GKGraphNode in path {
            if let point2d = node as? GKGraphNode2D {
                let point = CGPoint(x: CGFloat(point2d.position.x), y: CGFloat(point2d.position.y))
                let action = SKAction.moveTo(point, duration: 0.3)
                actions.append(action)
            }
        }
        
        // Convert those actions into a sequence action, then run it on the player node.
        let sequence = SKAction.sequence(actions)
        player?.runAction(sequence, completion: { () -> Void in
            // When the action completes, allow the player to move again.
            self.moving = false
        })
    }
}
