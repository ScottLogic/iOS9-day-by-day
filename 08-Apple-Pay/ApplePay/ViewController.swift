//
//  ViewController.swift
//  ApplePay
//
//  Created by Chris Grant on 30/06/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import UIKit
import PassKit

class ViewController: UIViewController, PKPaymentAuthorizationViewControllerDelegate {
	
	@IBOutlet weak var bottomToolbar: UIView!
	
	var paymentToken:PKPaymentToken!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let paymentButton = PKPaymentButton(type:.Buy, style:.Black)
		paymentButton.translatesAutoresizingMaskIntoConstraints = false
		paymentButton.addTarget(self, action: "buyNowButtonTapped:", forControlEvents: .TouchUpInside)
		bottomToolbar.addSubview(paymentButton)
		
		bottomToolbar.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .CenterX, relatedBy: .Equal, toItem: bottomToolbar, attribute: .CenterX, multiplier: 1, constant: 0))
		bottomToolbar.addConstraint(NSLayoutConstraint(item: paymentButton, attribute: .CenterY, relatedBy: .Equal, toItem: bottomToolbar, attribute: .CenterY, multiplier: 1, constant: 0))
	}
	
	func buyNowButtonTapped(sender: UIButton) {
		
		// Networks that we want to accept.
		let paymentNetworks = [PKPaymentNetworkAmex,
			PKPaymentNetworkMasterCard,
			PKPaymentNetworkVisa,
			PKPaymentNetworkDiscover]
		
		if PKPaymentAuthorizationViewController.canMakePaymentsUsingNetworks(paymentNetworks) {
			
			let request = PKPaymentRequest()
			
			// This merchantIdentifier should have been created for you in Xcode when you set up the ApplePay capabilities.
			request.merchantIdentifier = "shinobistore.com.day-by-day."
			request.countryCode = "US" // Standard ISO country code. The country in which you make the charge.
			request.currencyCode = "USD" // Standard ISO currency code. Any currency you like.
			request.supportedNetworks = paymentNetworks
			request.merchantCapabilities = .Capability3DS // 3DS or EMV. Check with your payment platform or processor.
			
			// Set the items that you are charging for. The last item is the total amount you want to charge.
			let shinobiToySummaryItem = PKPaymentSummaryItem(label: "Shinobi Cuddly Toy", amount: NSDecimalNumber(double: 22.99), type: .Final)
			let shinobiPostageSummaryItem = PKPaymentSummaryItem(label: "Postage", amount: NSDecimalNumber(double: 3.99), type: .Final)
			let shinobiTaxSummaryItem = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(double: 2.29), type: .Final)
			let total = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(double: 29.27), type: .Final)
			
			request.paymentSummaryItems = [shinobiToySummaryItem, shinobiPostageSummaryItem, shinobiTaxSummaryItem, total]
			
			// Create a PKPaymentAuthorizationViewController from the request
			let authorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: request)
			
			// Set its delegate so we know the result of the payment authorization
			authorizationViewController.delegate = self
			
			// Show the authorizationViewController to the user
			presentViewController(authorizationViewController, animated: true, completion: nil)
		}
		else {
			// Apple Pay is unavailable for these payment networks. Use a traditional checkout flow.
			print("Apple Pay is not available.")
		}
	}
	
	func paymentAuthorizationViewController(controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (PKPaymentAuthorizationStatus) -> Void) {
		
		paymentToken = payment.token
		
		// You would typically use a payment provider such as Stripe here using payment.token
		completion(.Success)
		
		// Once the payment is successful, show the user that the purchase has been successful.
		self.performSegueWithIdentifier("purchaseConfirmed", sender: self)
	}
	
	func paymentAuthorizationViewControllerDidFinish(controller: PKPaymentAuthorizationViewController) {
		self.dismissViewControllerAnimated(true, completion: nil)
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		let confirmation = segue.destinationViewController as! ConfirmationViewController
		confirmation.paymentToken = paymentToken!
	}
	
}
