//
//  TargetingComponent.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import GameKit

class TargetingComponent: GKAgent2D {
    
    let target:GKAgent2D
    
    required init(withTargetAgent targetAgent:GKAgent2D) {
        
        target = targetAgent
        
        super.init()

        let seek = GKGoal(toSeekAgent: targetAgent)
        
        self.behavior = GKBehavior(goals: [seek], andWeights: [1])
        
        self.maxSpeed = 4000
        self.maxAcceleration = 4000
        self.mass = 0.1
    }
    
}
