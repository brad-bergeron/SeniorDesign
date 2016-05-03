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
    var events = [SingleEvent]() //this will be pulled from the database always constant
    var sendEvent : SingleEvent?
    var eventTempImage: UIImage!
    var favorites = [SingleEvent]()
    var searchedEvents = [SingleEvent]() //The events that show up on page always
    var constantFilteredEvents = [SingleEvent]() //Holds the events that were filtered
    var loaded = false //Only want to load things from the Databse once
    var filtered = false //If it is filtered use the constantFilteredEvents instead of the events
    
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
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.triggerDeepLinkIfPresent()
        
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
        let cond = AWSDynamoDBCondition()
        let v1 = AWSDynamoDBAttributeValue()
        v1.S = "String"
        cond.comparisonOperator = AWSDynamoDBComparisonOperator.EQ
        cond.attributeValueList = [ v1 ]
        

        let queryExpression = AWSDynamoDBScanExpression()
        //queryExpression.limit = 10
        
        self.scan(queryExpression).continueWithBlock({ (task: AWSTask!) -> AWSTask! in
            if task.result != nil {
                    let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                    var count = 0
                    for item in paginatedOutput.items as! [SingleEvent] {
                        self.events.append(item)
                        if((count < self.events.count) && (self.events[count].Event_Picture_Link! != " ")){
                            self.downloadImage(NSURL( string: self.events[count].Event_Picture_Link!)!, count: count) { (result) -> () in
                                if(result==true){
                                    self.searchedEvents = self.events
                                    self.searchedEvents.sortInPlace({ $0.Event_NSDate!.compare($1.Event_NSDate!) == NSComparisonResult.OrderedAscending })
                                    self.tableView.reloadData()
                                }
                            }
                            
                        }
                        let dat = self.stringToDate(self.events[count].Event_Date_Formatted!, time: self.events[count].Event_Time!)
                        self.events[count].Event_NSDate = dat
                       
                        
                        count = count + 1
                    }
            }
            
            
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
    
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        if(searchText.isEmpty && filtered){
            searchedEvents = constantFilteredEvents
            
        } else if(searchText.isEmpty) {
            searchedEvents = events
        } else {
            searchedEvents = events.filter { SingleEvent in
                return SingleEvent.Event_Name!.lowercaseString.containsString(searchText.lowercaseString)
            }
        }


        self.events.sortInPlace({ $0.Event_NSDate!.compare($1.Event_NSDate!) == NSComparisonResult.OrderedAscending })
        self.searchedEvents.sortInPlace({ $0.Event_NSDate!.compare($1.Event_NSDate!) == NSComparisonResult.OrderedAscending })
        self.tableView.reloadData()

        
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
                    // Brad trying to right code to send the events array to Filter VIew Controller
                   dvc.unfilteredEvents = self.searchedEvents
                }
            }
        } else if segue.identifier == "RightSwipe" {
            if let nav = segue.destinationViewController as? FavoritesCollectionViewController {
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
        
        return searchedEvents.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //insert code to transition to event page

        self.sendEvent = searchedEvents[indexPath.row]
        //let dvc = EventPageViewController()
        //dvc.currentEvent = sendEvent
        self.performSegueWithIdentifier("EventViewSegue", sender: self)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EventTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventTableViewCell
        cell.event = searchedEvents[indexPath.row]
        cell.eventNameLabel.text = cell.event?.Event_Name
        let format = NSDateFormatter()
        format.dateFormat = "MM-dd-yyyy"
        let today = NSDate()
        if(format.stringFromDate(today)==format.stringFromDate(cell.event.Event_NSDate!)){
            cell.eventDateLabel.text = "Today"
        } else if (format.stringFromDate(today)==format.stringFromDate(cell.event.Event_NSDate!.dateByAddingTimeInterval(60*60*24))) {
            cell.eventDateLabel.text = "Tomorrow"
        } else {
            cell.eventDateLabel.text = format.stringFromDate(cell.event.Event_NSDate!)
        }
        //cell.eventDateLabel.text = "Today"
        cell.eventImage.contentMode = UIViewContentMode.ScaleAspectFit
        cell.eventImage.image = cell.event?.Event_Picture
        //print(filteredEvents[indexPath.row].Event_Time!)
        
        
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
                //DO NOT REMOVE THESE PRINTS
                print(response?.suggestedFilename ?? "")
                print("download Finished")
                
                self.events[count].Event_Picture = UIImage(data: data)
                
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
    // MARK: NSDate Function
    func stringToDate(date: String, time: String) -> NSDate?{
        var dateReturn = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMddyyHHmm"
        dateFormatter.timeZone = NSTimeZone(abbreviation: "CST")
        print("Time:" + time)
        var tme : String
        //print("Start char:" + String(time![time!.startIndex]) + "&")
        if(time[time.startIndex] == " "){
            let adv = time.startIndex.advancedBy(1)
            tme = time.substringFromIndex(adv)
        } else {
            tme = time
        }
        let temp = tme.characters.split{$0 == ":"}
        var hours = String(temp[0])
        if(tme.containsString("pm") || tme.containsString("PM")){
            hours = String(Int(hours)! + 12)
        }
        if(hours.characters.count == 1){
            let temp2 = hours
            hours = "0"
            hours.appendContentsOf(temp2)
        }
        let minutes = String(String(temp[1]).characters.split{$0 == " "}[0])
        var dateVal = date
        dateVal.appendContentsOf(hours)
        dateVal.appendContentsOf(minutes)
        dateReturn = dateFormatter.dateFromString(dateVal) as NSDate! 
        return dateReturn
    }
    
    //help and settings
    //NEED TO SEGUE BETWEEN VIEWS
    
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if(favorites.contains(self.searchedEvents[indexPath.row])){
            let unfavoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Remove from Favorites", handler: {action, indexpath in
                let unfavoriteEvent : SingleEvent = self.searchedEvents[indexPath.row]
                if(!FavoritesCollectionViewController().containsEvent(unfavoriteEvent)){
                    FavoritesCollectionViewController().removeFavorite(unfavoriteEvent)
                    tableView.setEditing(false, animated: true)
                }
            });
            unfavoriteAction.backgroundColor = UIColor.redColor();
            return [unfavoriteAction]
        } else{
        let favoriteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "  Favorite  ", handler: {action, indexpath in
                let favoriteEvent : SingleEvent = self.searchedEvents[indexPath.row]
                if (!FavoritesCollectionViewController().containsEvent(favoriteEvent)){
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
