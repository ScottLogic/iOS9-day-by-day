//
//  DetailViewController.swift
//  ContactsFramework
//
//  Created by Chris Grant on 29/06/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import UIKit
import Contacts

class DetailViewController: UIViewController {

    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneNumberLabel: UILabel!

    var contact: CNContact? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the contact item.
        if let contact = self.contact {
            if let label = self.contactNameLabel {
                label.text = CNContactFormatter.stringFromContact(contact, style: .FullName)
            }
            
            if let imageView = self.contactImageView {
                if contact.imageData != nil {
                    imageView.image = UIImage(data: contact.imageData!)
                }
                else {
                    imageView.image = nil
                }
            }
            
            if let phoneNumberLabel = self.contactPhoneNumberLabel {
                var numberArray = [String]()
                for number in contact.phoneNumbers {
                    let phoneNumber = number.value as! CNPhoneNumber
                    numberArray.append(phoneNumber.stringValue)
                }
                phoneNumberLabel.text = numberArray.joinWithSeparator(", ")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }
}
