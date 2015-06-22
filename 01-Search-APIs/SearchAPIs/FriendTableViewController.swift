//
//  TableViewController.swift
//  SearchAPIs
//
//  Created by Chris Grant on 18/06/2015.
//  Copyright © 2015 Scott Logic Ltd. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {
    
    let datasource = Datasource()
    
    var lastSelectedFriend: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        datasource.savePeopleToIndex()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! FriendViewController
        destination.person = lastSelectedFriend!
    }
    
    func showFriend(id: String) {
        lastSelectedFriend = datasource.friendFromID(id)
        performSegueWithIdentifier("showFriend", sender: self)
    }
}

extension FriendTableViewController  {
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let person = datasource.people[indexPath.row]
        cell?.textLabel?.text = person.name
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.people.count
    }
    
    // This shouldn't be necessary as the tap action is in the Storyboard, but it doesn't seem to be working in beta 1.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedIndex = tableView.indexPathForSelectedRow?.row
        lastSelectedFriend = datasource.people[selectedIndex!]
        
        performSegueWithIdentifier("showFriend", sender: self)
    }
}
