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
    var missile:Missile? // Can't initialise missile here as it needs the player object as a target in it's initialiser.
    
    var lastUpdateTimeInterval: NSTimeInterval = 0
    
    lazy var componentSystems: [GKComponentSystem] = {
        let targetingSystem = GKComponentSystem(componentClass: TargetingComponent.self)
        let renderSystem = GKComponentSystem(componentClass: RenderComponent.self)
        return [targetingSystem, renderSystem]
    }()
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        player.node.position = CGPointMake(100, 100)
        self.addChild(player.node)
        
        // Setup the missile entity with the player's agent as it's target.
        missile = Missile(withTargetAgent: player.agent)
        // Pass the scene to the setupEmitters function so that the emitters leave a trail, rather than moving with the
        // missile itself.
        missile!.setupEmitters(withTargetScene: self)
        self.addChild(missile!.node)

        // Add the player and missile entity components to the component systems
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
    
    // Called before each frame is rendered.
    override func update(currentTime: NSTimeInterval) {
        
        // Calculate the amount of time since `update` was last called.
        let deltaTime = currentTime - lastUpdateTimeInterval
        
        // Update every component system in the componentSystems array with the delta time.
        for componentSystem in componentSystems {
            componentSystem.updateWithDeltaTime(deltaTime)
        }
        
        lastUpdateTimeInterval = currentTime
    }
}
