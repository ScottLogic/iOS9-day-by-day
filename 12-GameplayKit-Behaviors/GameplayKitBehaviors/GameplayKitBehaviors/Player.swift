//
//  Player.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import GameKit

class Player: GKEntity, GKAgentDelegate {
    
    var agent:GKAgent2D = GKAgent2D()
    var node:SKNode?

    override init() {
        super.init()
        agent.delegate = self
    }
    
    func agentDidUpdate(agent: GKAgent) {
        if let agent2d = agent as? GKAgent2D {
            node!.position = CGPoint(x: CGFloat(agent2d.position.x), y: CGFloat(agent2d.position.y))
        }
    }
    
    func agentWillUpdate(agent: GKAgent) {
        if let agent2d = agent as? GKAgent2D {
            agent2d.position = float2(Float(node!.position.x), Float(node!.position.y))
        }
    }
}
