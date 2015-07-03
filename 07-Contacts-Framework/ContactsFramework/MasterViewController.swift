//
//  MasterViewController.swift
//  ContactsFramework
//
//  Created by Chris Grant on 29/06/2015.
//  Copyright © 2015 Shinobi Controls. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class MasterViewController: UITableViewController, CNContactPickerDelegate {

    var detailViewController: DetailViewController? = nil
    var contacts = [CNContact]()

    override func viewDidLoad() {
        super.viewDidLoad()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            self.contacts = self.findContacts()
            
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView!.reloadData()
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }
    
    func findContacts() -> [CNContact] {
        let store = CNContactStore()

        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName),
            CNContactImageDataKey,
            CNContactPhoneNumbersKey]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        var contacts = [CNContact]()
        
        do {
            try store.enumerateContactsWithFetchRequest(fetchRequest, usingBlock: { (let contact, let stop) -> Void in
                contacts.append(contact)
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return contacts
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let contact = contacts[indexPath.row] as CNContact
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.contact = contact
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let contact = contacts[indexPath.row] as CNContact
        cell.textLabel!.text = "\(contact.givenName) \(contact.familyName)"
        return cell
    }
    
    // MARK: - Contacts Picker
    
    @IBAction func showContactsPicker(sender: UIBarButtonItem) {
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        contactPicker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        
        self.presentViewController(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        let phoneNumber = contactProperty.value as! CNPhoneNumber
        
        print(contact.givenName)
        print(phoneNumber.stringValue)
    }
}
