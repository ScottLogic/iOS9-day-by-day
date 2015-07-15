//
//  PlayerNode.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 13/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import GameKit
import SpriteKit

class PlayerNode: EntityNode {
    
    let shape = SKShapeNode(rect: CGRectMake(0, 0, 40, 40))
    
    override init() {
        super.init()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        shape.fillColor = .yellowColor()
        addChild(shape)
    }
    
}
