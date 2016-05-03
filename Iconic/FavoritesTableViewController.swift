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
    var favorites = [SingleEvent]()
    var sendEvent : SingleEvent?
    var center : CGPoint?
    
    @IBOutlet weak var favoriteSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        cell.eventNameLabel.text = favorites[indexPath.row].Event_Name
        cell.eventDateLabel.text = "TODAY"
        cell.eventCostLabel.text = String(format: "%.2f",favorites[indexPath.row].Event_Price!)
        cell.eventLocationLabel.text = favorites[indexPath.row].Event_Location
        //if(favorites[indexPath.row].
          //  cell.eventImage.image
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.sendEvent = favorites[indexPath.row]
        self.performSegueWithIdentifier("FavoriteSegue", sender: self)
    }
    
    func containsEvent(event: SingleEvent) -> Bool {
        if(favorites.contains(event)){
            return true
        }
        return false
    }
    
    func addFavorite(event: SingleEvent) {
        if(!containsEvent(event)){
            self.favorites.append(event)
        }
    }
    
    func removeFavorite(event: SingleEvent) {
        if(favorites.contains(event)){
            if let index = self.favorites.indexOf(event){
                self.favorites.removeAtIndex(index)
            }
        }
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
