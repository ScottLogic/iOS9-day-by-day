//
//  ViewController.swift
//  SearchAPIs
//
//  Created by Chris Grant on 18/06/2015.
//  Copyright © 2015 Scott Logic Ltd. All rights reserved.
//

import UIKit
import CoreSpotlight

class FriendViewController: UIViewController {
    
    var person: Person!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = person.name
        imageView.image = person.image
    }
}
