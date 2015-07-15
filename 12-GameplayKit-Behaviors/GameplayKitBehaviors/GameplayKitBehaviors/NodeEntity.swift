//
//  NodeEntity.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 15/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import GameKit

class NodeEntity: GKEntity {
    
    var node:EntityNode {
        get {
            return componentForClass(RenderComponent.self)!.node
        }
    }
    
}
