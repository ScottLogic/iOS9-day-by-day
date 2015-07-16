//
//  RenderComponent.swift
//  GameplayKitBehaviors
//
//  Created by Chris Grant on 14/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import SpriteKit
import GameplayKit

class RenderComponent: GKComponent {
    
    // The `RenderComponent` vends a node allowing an entity to be rendered in a scene.
    let node = EntityNode()
    
    init(entity: GKEntity) {
        node.entity = entity
    }
}
