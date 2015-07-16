//
//  Missile.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import GameKit
import SpriteKit

class MissileAgent: GKAgent2D {}

class Missile: NodeEntity, GKAgentDelegate {
    
    var agent:MissileAgent = MissileAgent()
    
    let missileNode = MissileNode()
    
    required init(withTargetAgent targetAgent:GKAgent2D) {
        super.init()
        
        let renderComponent = RenderComponent(entity: self)
        renderComponent.node.addChild(missileNode)
        addComponent(renderComponent)
        
        let targetingComponent = TargetingComponent(withTargetAgent: targetAgent)
        targetingComponent.delegate = self
        addComponent(targetingComponent)
        
        agent.delegate = self
        addComponent(agent)
    }
    
    func setupEmitters(withTargetScene scene:SKScene) {
        missileNode.setupEmitters(withTargetScene: scene)
    }
    
    func agentDidUpdate(agent: GKAgent) {
        if let agent2d = agent as? GKAgent2D {
            node.position = CGPoint(x: CGFloat(agent2d.position.x), y: CGFloat(agent2d.position.y))
            node.zRotation = CGFloat(agent2d.rotation)
            print(node.position)
        }
    }
    
    func agentWillUpdate(agent: GKAgent) {
        if let agent2d = agent as? GKAgent2D {
            agent2d.position = float2(Float(node.position.x), Float(node.position.y))
            agent2d.rotation = Float(node.zRotation)
        }
    }
    
}
