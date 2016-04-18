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
    var favorites = [SingleEvent?]()
    var sendEvent : SingleEvent?
    var center : CGPoint?
    
    @IBOutlet weak var favoriteSearch: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadFavorites()
        loadEvents()
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
        
        let cond = AWSDynamoDBCondition()
        let v1 = AWSDynamoDBAttributeValue()
        v1.S = "String"
        cond.comparisonOperator = AWSDynamoDBComparisonOperator.EQ
        cond.attributeValueList = [ v1 ]
        
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        let queryExpression = AWSDynamoDBScanExpression()
        queryExpression.limit = 20
        queryExpression.filterExpression = "(contains(Event_Name, :event_name))"
        queryExpression.expressionAttributeValues = [":event_name": "D"]
        
        dynamoDBObjectMapper.scan(SingleEvent.self, expression: queryExpression).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            
            if task.result != nil {
                let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                for item in paginatedOutput.items as! [SingleEvent] {
                    
                    self.favorites.append(item)
                    
                    
                }
                
                
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                
            })
            
            if ((task.error) != nil) {
                print("Error: \(task.error)")
            }
            return nil
        })
        
    }
    
    func loadEvents(){
        
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
        cell.eventNameLabel.text = favorites[indexPath.row]!.Event_Name
        cell.eventDateLabel.text = "TODAY"
        cell.eventCostLabel.text = String(format: "%.2f",favorites[indexPath.row]!.Event_Price!)
        cell.eventLocationLabel.text = favorites[indexPath.row]!.Event_Location
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
