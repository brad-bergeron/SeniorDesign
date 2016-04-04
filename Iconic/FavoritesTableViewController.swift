//
//  FavoritesTableViewController.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/15/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController{

    // MARK: Event Properties
    var favorites = [Event?]()
    var sendEvent : Event?
    var center : CGPoint?
    
    @IBOutlet weak var favoriteSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFavorites()
        initSwipes()
        //self.searchDisplayController
       // favoriteSearch.searchResultsUpdater = self
       // favoriteSearch.dimsBackgroundDuringPresentation = false
        
        definesPresentationContext = true
        self.tableView.backgroundColor = UIColor.blackColor()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initSwipes() {
        //let leftswipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        let rightswipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(FavoritesTableViewController.handleSwipe(_:)))
        //leftswipe.direction = .Left
        rightswipe.edges = .Left
        
        
        //view.addGestureRecognizer(leftswipe)
        view.addGestureRecognizer(rightswipe)
    }
    
    func loadFavorites() {
     //load favorites
        
        for _ in 1...20 {
            let event = Event(eventName: "Some Event", eventLoc: "IMU",eventDate: NSDate(), eventPhoto: nil, eventCost: 25.00, eventLink: "www.comedycentral.com", eventDetails: "Stand up comedy performance at the IMU")
            let event1 = Event(eventName: "Another Event", eventLoc: "IMU2",eventDate: NSDate(), eventPhoto: nil, eventCost: 25.00, eventLink: "www.comedycentral.com", eventDetails: "Stand up comedy performance at the IMU")
            favorites += [event, event1]
        }
        
    }
    
    func handleSwipe(sender: UIPanGestureRecognizer) {
        if let edge = sender as? UIScreenEdgePanGestureRecognizer{
            if (edge.edges == .Left && sender.state == .Recognized){
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
        //else if (sender.direction == .Right) {
            //    performSegueWithIdentifier("RightSwipe", sender: self)
            
        //}
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FavoriteSegue" {
            if let nav = segue.destinationViewController as? UINavigationController{
                if let dvc = nav.topViewController as? EventPageViewController{
                    dvc.currentEvent = self.sendEvent
                }
            }
        }
    }
    
    //ADD GRADIENT LATER MAYBE
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FavoriteCell", forIndexPath: indexPath) as! FavoriteTableViewCell
        cell.eventNameLabel.text = favorites[indexPath.row]!.eventName
        cell.eventDateLabel.text = "TODAY"
        cell.eventCostLabel.text = String(format: "%.2f",favorites[indexPath.row]!.eventCost!)
        cell.eventLocationLabel.text = favorites[indexPath.row]!.eventLoc
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.sendEvent = favorites[indexPath.row]
        self.performSegueWithIdentifier("FavoriteSegue", sender: self)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  

}
