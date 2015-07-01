//
//  ConfirmationViewController.swift
//  ApplePay
//
//  Created by CG on 30/06/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import UIKit
import PassKit

class ConfirmationViewController: UIViewController {
	
	var paymentToken:PKPaymentToken!
	
	@IBOutlet var idLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.idLabel.text = self.paymentToken.transactionIdentifier
	}
	
}
