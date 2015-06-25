//
//  ViewController.swift
//  UIStackView
//
//  Created by Chris Grant on 25/06/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var peopleStackView: UIStackView!

    @IBAction func segmentSelected(sender: UISegmentedControl) {
        
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            options: .CurveEaseInOut,
            animations: { () -> Void in
                
                if sender.selectedSegmentIndex == 0 {
                    self.peopleStackView.alignment = .Fill
                }
                else if sender.selectedSegmentIndex == 1 {
                    self.peopleStackView.alignment = .Top
                }
                else if sender.selectedSegmentIndex == 2 {
                    self.peopleStackView.alignment = .Center
                }
                else if sender.selectedSegmentIndex == 3 {
                    self.peopleStackView.alignment = .Bottom
                }
            },
            completion: nil)
    }
    
    @IBAction func distributionSegmentSelected(sender: UISegmentedControl) {
        UIView.animateWithDuration(1.0,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            options: .CurveEaseInOut,
            animations: { () -> Void in
                
                if sender.selectedSegmentIndex == 0 {
                    self.peopleStackView.distribution = .Fill
                }
                else if sender.selectedSegmentIndex == 1 {
                    self.peopleStackView.distribution = .FillEqually
                }
                else if sender.selectedSegmentIndex == 2 {
                    self.peopleStackView.distribution = .FillProportionally
                }
                else if sender.selectedSegmentIndex == 3 {
                    self.peopleStackView.distribution = .EqualSpacing
                }
                else if sender.selectedSegmentIndex == 4 {
                    self.peopleStackView.distribution = .EqualCentering
                }
            },
            completion: nil)
    }
}
