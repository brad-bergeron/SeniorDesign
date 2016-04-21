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
    var filteredEvents = [SingleEvent]()
    var loaded = false;
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (loaded == false){
            loadEvents()
        }
        //loadEvents()
        initSwipes()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
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
        //queryExpression.limit = 20
        //queryExpression.filterExpression = "(contains(Event_Name, :event_name))"
        //queryExpression.expressionAttributeValues = [":event_name": "Train"]
        
        
        self.scan(queryExpression).continueWithBlock({ (task: AWSTask!) -> AWSTask! in
            if task.result != nil {
                    let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                    var count = 0
                    for item in paginatedOutput.items as! [SingleEvent] {
                        self.filteredEvents.append(item)
                        self.events.append(item)
                        if(count < self.filteredEvents.count){
                            self.downloadImage(NSURL( string: self.events[count].Event_Picture_Link!)!, count: count) { (result) -> () in
                                if(result==true){
                                    self.tableView.reloadData()
                                }
                            }
                            
                        }
                        count = count + 1
                    }
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
                self.loaded = true
                
            })
            
            
            if ((task.error) != nil) {
                print("Error: \(task.error)")
            }
            return nil
        })
        
    }
    
    //Code for inline NSURL download, save just in case
    // let url = NSURL(string: (self.events[count].Event_Picture_Link)!)
    // NSURLSession.sharedSession().dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void in
    //dispatch_async(dispatch_get_main_queue()) { () -> Void in
    //guard let data = data where error == nil else { return }
    //print(response?.suggestedFilename ?? "")
    //print("download Finished")
   
    //self.filteredEvents[count].Event_Picture = UIImage(data: data)
    //self.events[count].Event_Picture = UIImage(data: data)
    
    //}
    // }.resume()

    
    func scan (expression : AWSDynamoDBScanExpression) -> AWSTask! {
        let mapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        return mapper.scan(SingleEvent.self, expression: expression)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        if(searchText.isEmpty){
            filteredEvents = events;
        } else {
            filteredEvents = events.filter { SingleEvent in
                return SingleEvent.Event_Name!.lowercaseString.containsString(searchText.lowercaseString)
            }
        }

        //dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        //})
        
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
        
        return filteredEvents.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //insert code to transition to event page

        self.sendEvent = filteredEvents[indexPath.row]
        //let dvc = EventPageViewController()
        //dvc.currentEvent = sendEvent
        self.performSegueWithIdentifier("EventViewSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EventTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        cell.event = filteredEvents[indexPath.row]
        cell.eventNameLabel.text = cell.event?.Event_Name
        cell.eventDateLabel.text = "Today"
        cell.eventImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.eventImage.image = cell.event?.Event_Picture
        
        
        // Configure the cell...
        
        return cell
    }
    
    func getDataFromUrl( url:NSURL, completion: ((data: NSData?, response: NSURLResponse?, error: NSError? ) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(url) { ( data, response, error) in
            completion(data: data, response: response, error: error)
            }.resume()
    }
    
    func downloadImage(url: NSURL, count: Int, completion: (result: Bool) -> ()) {
        getDataFromUrl(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                guard let data = data where error == nil else { return }
                print(response?.suggestedFilename ?? "")
                print("download Finished")
                
                self.events[count].Event_Picture = UIImage(data: data)
                if(count < self.filteredEvents.count){
                    self.filteredEvents[count].Event_Picture = UIImage(data: data)
                }
                
                completion(result: true)
            }

            
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
        if(favorites.contains(self.filteredEvents[indexPath.row])){
            let unfavoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Remove from Favorites", handler: {action, indexpath in
                let unfavoriteEvent : SingleEvent = self.filteredEvents[indexPath.row]
                if(!FavoritesTableViewController().containsEvent(unfavoriteEvent)){
                    FavoritesTableViewController().removeFavorite(unfavoriteEvent)
                }
            });
            unfavoriteAction.backgroundColor = UIColor.redColor();
            return [unfavoriteAction]
        } else{
        let favoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "  Favorite  ", handler: {action, indexpath in
                let favoriteEvent : SingleEvent = self.filteredEvents[indexPath.row]
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

extension EventTableViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
            filterContentForSearchText(searchController.searchBar.text!)
    
    }
}
