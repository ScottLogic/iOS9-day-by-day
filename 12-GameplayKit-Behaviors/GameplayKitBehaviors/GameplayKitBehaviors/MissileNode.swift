//
//  MissileNode.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import GameKit
import SpriteKit

class MissileNode: EntityNode {
    
    let fire = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("MissileFire", ofType:"sks")!) as! SKEmitterNode
    let smoke = NSKeyedUnarchiver.unarchiveObjectWithFile(NSBundle.mainBundle().pathForResource("MissileSmoke", ofType:"sks")!) as! SKEmitterNode
    
    func setupEmitters(withTargetScene scene:SKScene) {
        smoke.targetNode = scene
        self.addChild(smoke)
        
        fire.targetNode = scene
        self.addChild(fire)
    }
    
    var targetAgent:GKAgent2D? {
        didSet {
            entity = Missile(withTargetAgent: targetAgent!)
        }
    }
    
    override var zRotation: CGFloat {
        didSet {
            fire.emissionAngle = zRotation
        }
    }
    
}
