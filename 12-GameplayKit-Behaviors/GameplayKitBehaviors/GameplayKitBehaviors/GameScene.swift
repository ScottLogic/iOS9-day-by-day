//
//  GameScene.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright (c) 2015 Shinobi Controls. All rights reserved.
//

import SpriteKit
import GameKit

class GameScene: SKScene {
    
    let player:Player = Player()
    var missile:Missile?
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        player.node.position = CGPointMake(100, 100)
        self.addChild(player.node)
        
        missile = Missile(withTargetAgent: player.agent)
        missile!.setupEmitters(withTargetScene: self)
        self.addChild(missile!.node)

        // Add the entity components to the component systems
        for componentSystem in self.componentSystems {
            componentSystem.addComponentWithEntity(player)
            componentSystem.addComponentWithEntity(missile!)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            player.agent.position = float2(Float(location.x), Float(location.y))
            player.agent.delegate!.agentDidUpdate!(player.agent)
        }
    }
    
    var lastUpdateTimeInterval: NSTimeInterval = 0
    
    lazy var componentSystems: [GKComponentSystem] = {
        let targetingSystem = GKComponentSystem(componentClass: TargetingComponent.self)
        let renderSystem = GKComponentSystem(componentClass: RenderComponent.self)
        return [targetingSystem, renderSystem]
    }()
    
    // Called before each frame is rendered.
    override func update(currentTime: NSTimeInterval) {
        
        // Calculate the amount of time since `update` was last called.
        let deltaTime = currentTime - lastUpdateTimeInterval
        
        for componentSystem in componentSystems {
            componentSystem.updateWithDeltaTime(deltaTime)
        }
        
        lastUpdateTimeInterval = currentTime
    }
}
