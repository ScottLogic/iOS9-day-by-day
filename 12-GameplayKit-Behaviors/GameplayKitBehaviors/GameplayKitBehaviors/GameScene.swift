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
    
    let playerNode:PlayerNode = PlayerNode()
    let player:Player = Player()
    
    let missileNode:MissileNode = MissileNode()
    var missile:Missile?
    
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
    
        let playerRenderComponent = RenderComponent(entity: player)
        playerRenderComponent.node.addChild(playerNode)
        self.addChild(playerRenderComponent.node)

        
        missileNode.setupEmitters(withTargetScene: self)

        missile = Missile(withTargetAgent: player.agent)
        missile!.node = missileNode
        missileNode.entity = missile
        self.addChild(missileNode)
        
        // Add the entity components to the component systems
        for componentSystem in self.componentSystems {
            componentSystem.addComponentWithEntity(player)
            componentSystem.addComponentWithEntity(missile!)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            
            playerNode.position = location
            player.agent.position = float2(Float(location.x), Float(location.y))
        }
    }
    
    var lastUpdateTimeInterval: NSTimeInterval = 0
    let maximumUpdateDeltaTime: NSTimeInterval = 1.0 / 60.0
    
    lazy var componentSystems: [GKComponentSystem] = {
        let targetingSystem = GKComponentSystem(componentClass: TargetingComponent.self)
        let renderSystem = GKComponentSystem(componentClass: RenderComponent.self)
        return [targetingSystem, renderSystem]
    }()
    
    // Called before each frame is rendered.
    override func update(currentTime: NSTimeInterval) {
        
        // Calculate the amount of time since `update` was last called.
        var deltaTime = currentTime - lastUpdateTimeInterval
        
        // If more than `maximumUpdateDeltaTime` has passed, clamp to the maximum; otherwise use `deltaTime`.
        deltaTime = deltaTime > maximumUpdateDeltaTime ? maximumUpdateDeltaTime : deltaTime
        
        // The current time will be used as the last update time in the next execution of the method.
        lastUpdateTimeInterval = currentTime
        
        // Don't evaluate any updates if the scene is paused.
        if paused { return }
        
        // Update each component system.
        for componentSystem in componentSystems {
            componentSystem.updateWithDeltaTime(deltaTime)
        }
    }
}
