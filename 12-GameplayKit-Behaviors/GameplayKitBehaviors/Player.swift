//
//  Player.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import GameKit

class PlayerAgent: GKAgent2D {}

class Player: NodeEntity, GKAgentDelegate {
    
    let agent:PlayerAgent = PlayerAgent()

    override init() {
        super.init()
        
        let renderComponent = RenderComponent(entity: self)
        renderComponent.node.addChild(PlayerNode())
        addComponent(renderComponent)
        
        agent.delegate = self
        addComponent(agent)
    }
    
    func agentDidUpdate(agent: GKAgent) {
        if let agent2d = agent as? GKAgent2D {
            node.position = CGPoint(x: CGFloat(agent2d.position.x), y: CGFloat(agent2d.position.y))
        }
    }
    
    func agentWillUpdate(agent: GKAgent) {
        if let agent2d = agent as? GKAgent2D {
            agent2d.position = float2(Float(node.position.x), Float(node.position.y))
        }
    }
}
