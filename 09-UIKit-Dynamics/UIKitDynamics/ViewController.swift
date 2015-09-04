//
//  ViewController.swift
//  UIKitDynamics
//
//  Created by Chris Grant on 02/07/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import UIKit
import CoreMotion

class Ellipse: UIView {
    override var collisionBoundsType: UIDynamicItemCollisionBoundsType {
        return .Ellipse
    }
}

class ViewController: UIViewController {

    var animator: UIDynamicAnimator!
    let manager:CMMotionManager = CMMotionManager()
    
    let noiseField:UIFieldBehavior = UIFieldBehavior.noiseFieldWithSmoothness(1.0, animationSpeed: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up a UIDynamicAnimator on the view.
        animator = UIDynamicAnimator(referenceView: view)
        
        // Add two views to the view
        let square = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        square.backgroundColor = .blueColor()
        view.addSubview(square)
        
        let ellipse = Ellipse(frame: CGRect(x: 0, y: 100, width: 100, height: 100))
        ellipse.backgroundColor = .yellowColor()
        ellipse.layer.cornerRadius = 50
        view.addSubview(ellipse)
        
        let items = [square, ellipse]
        
        // Create some gravity so the items always fall towards the bottom.
        let gravity = UIGravityBehavior(items: items)
        animator.addBehavior(gravity)

        // Set up the noise field
        noiseField.addItem(square)
        noiseField.addItem(ellipse)
        noiseField.strength = 0.5
        animator.addBehavior(noiseField)
        
        // Don't let objects overlap each other - set up a collide behaviour
        let collision = UICollisionBehavior(items: items)
        collision.setTranslatesReferenceBoundsIntoBoundaryWithInsets(UIEdgeInsets(top: 20, left: 5, bottom: 5, right: 5))
        animator.addBehavior(collision)

        // Used to alter the gravity so it always points down.
        if manager.deviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.1
            manager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler:{
                deviceManager, error in
                gravity.gravityDirection = CGVector(dx: deviceManager!.gravity.x, dy: -deviceManager!.gravity.y)
            })
        }
        
        animator.debugEnabled = true // Private API. See the bridging header. Do not release!
    }
    
    @IBAction func smoothnessValueChanged(sender: UISlider) {
        noiseField.smoothness = CGFloat(sender.value)
    }
    
    @IBAction func speedValueChanged(sender: UISlider) {
        noiseField.animationSpeed = CGFloat(sender.value)
    }
    
    @IBAction func strengthValueChanged(sender: UISlider) {
        noiseField.strength = CGFloat(sender.value)
    }
}
