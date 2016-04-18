//
//  EventTableViewController.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/5/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit


class EventTableViewController: UITableViewController {
    
    // MARK: Event List
    var events = [SingleEvent]() //this will be pulled from the database
    var sendEvent : SingleEvent?
    var eventTempImage: UIImage!
    var favorites = [SingleEvent]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
        initSwipes()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func initSwipes() {
        let leftswipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(EventTableViewController.handleSwipe(_:)))
        let rightswipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(EventTableViewController.handleSwipe(_:)))
        
        leftswipe.edges = .Left
        rightswipe.edges = .Right
        
        view.addGestureRecognizer(leftswipe)
        view.addGestureRecognizer(rightswipe)
    }
    
    func loadEvents() {
        //let photo = UIImage(named: "KevinHart")!
        let cond = AWSDynamoDBCondition()
        let v1 = AWSDynamoDBAttributeValue()
        v1.S = "String"
        cond.comparisonOperator = AWSDynamoDBComparisonOperator.EQ
        cond.attributeValueList = [ v1 ]
        
        //let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        let queryExpression = AWSDynamoDBScanExpression()
        queryExpression.limit = 20
        //queryExpression.filterExpression = "(contains(Event_Name, :event_name))"
        //queryExpression.expressionAttributeValues = [":event_name": "Train"]
        
        
        
        self.scan(queryExpression).continueWithBlock({ (task: AWSTask!) -> AWSTask! in
            if task.result != nil {
                let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                for item in paginatedOutput.items as! [SingleEvent] {
                    self.events.append(item)
                    //print(item)
                    //self.downloadImage(NSURL(string: (item.Event_Picture_Link)!)!)
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
    
    func scan (expression : AWSDynamoDBScanExpression) -> AWSTask! {
        let mapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        return mapper.scan(SingleEvent.self, expression: expression)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Segue functions
    override func prepareForSegue(segue:UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EventViewSegue" {
            if let nav = segue.destinationViewController as? UINavigationController{
                if let dvc = nav.topViewController as? EventPageViewController{
                    dvc.currentEvent = self.sendEvent
                    
                }
            }
        } else if segue.identifier == "LeftSwipe" {
            if let nav = segue.destinationViewController as? UINavigationController{
                if let dvc = nav.topViewController as? FilterViewController{
                    // send some data
                }
            }
        } else if segue.identifier == "RightSwipe" {
            if let nav = segue.destinationViewController as? FavoritesTableViewController {
                // do something with nav data
                for fave in self.favorites{
                    nav.favorites.append(fave)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //insert code to transition to event page
        self.sendEvent = events[indexPath.row]
        //let dvc = EventPageViewController()
        //dvc.currentEvent = sendEvent
        self.performSegueWithIdentifier("EventViewSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EventTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        cell.event = events[indexPath.row]
        cell.eventNameLabel.text = cell.event?.Event_Name
        cell.eventDateLabel.text = "Today"
        //downloadImage(NSURL(string: (cell.event?.Event_Picture_Link)!)!, cellForRowAtIndexPath: indexPath)
        
        let url = NSURL(string: (cell.event?.Event_Picture_Link)!)
        
        NSURLSession.sharedSession().dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("download Finished")
                
                cell.eventImage.image = UIImage(data: data)
            }
        }.resume()
        
        //cell.eventImage.image = self.eventTempImage
        
        // Configure the cell...
        
        return cell
    }
    
    func getDataFromUrl( url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { ( data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL,  cellForRowAtIndexPath indexPath: NSIndexPath) {
        getDataFromUrl(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("download Finished")
                
                self.eventTempImage = UIImage(data: data)
            }
            
            /*dispatch_async(dispatch_get_main_queue()) { () -> Void in
             self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.None)
             
             }*/
            
        }
    }
    
    func handleSwipe(sender: UIScreenEdgePanGestureRecognizer) {
        if (sender.state == .Recognized) {
            if (sender.edges == .Right){
                performSegueWithIdentifier("RightSwipe", sender: self)
            } else if (sender.edges == .Left) {
                performSegueWithIdentifier("LeftSwipe", sender: self)
                
            }
        }
    }
    
    @IBAction func unwindFromFilters(sender: UIStoryboardSegue) {
        //insert some data here
        if sender.identifier == "LeftSwipe" {
            
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
    
    //NEED TO SEGUE BETWEEN VIEWS
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if(favorites.contains(self.events[indexPath.row])){
            let unfavoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: " Remove from Favorites ", handler: {action, indexpath in
                let unfavoriteEvent : SingleEvent = self.events[indexPath.row]
                if(!FavoritesTableViewController().containsEvent(unfavoriteEvent)){
                    if let index = self.favorites.indexOf(unfavoriteEvent){
                        self.favorites.removeAtIndex(index)
                        tableView.setEditing(false, animated: true)
                    }
                }
            });
            unfavoriteAction.backgroundColor = UIColor.redColor();
            return [unfavoriteAction]
        } else{
        let favoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "  Favorite  ", handler: {action, indexpath in
                let favoriteEvent : SingleEvent = self.events[indexPath.row]
                if (!FavoritesTableViewController().containsEvent(favoriteEvent)){
                    self.favorites.append(favoriteEvent)
                    tableView.setEditing(false, animated: true)
                }
            });
            favoriteAction.backgroundColor = UIColor.blackColor();
            return [favoriteAction];
        }
    }
    
    func handleFavorite(sender: UITableViewRowAction){
        if (sender.title == "Favorite"){
                //Print something here
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
}
