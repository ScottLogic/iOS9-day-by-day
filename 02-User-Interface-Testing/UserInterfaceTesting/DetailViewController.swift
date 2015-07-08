//
//  DetailViewController.swift
//  UserInterfaceTesting
//
//  Created by Chris Grant on 23/06/2015.
//  Copyright © 2015 ShinobiControls. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var value = 0
    
    @IBOutlet weak var valueLabel: UILabel!

    @IBAction func incrementTapped(sender: UIButton) {
        value++
        valueLabel.text = "\(value)"
        valueLabel.accessibilityValue = valueLabel.text
    }
}
