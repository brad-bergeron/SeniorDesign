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
    var events = [Event?]() //this will be pulled from the database
    var sendEvent : Event?

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
    
    func loadEvents(){
        //let photo = UIImage(named: "KevinHart")!
        let cond = AWSDynamoDBCondition()
        let v1 = AWSDynamoDBAttributeValue()
        v1.S = "String"
        cond.comparisonOperator = AWSDynamoDBComparisonOperator.EQ
        cond.attributeValueList = [ v1 ]
        
        let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.defaultDynamoDBObjectMapper()
        let queryExpression = AWSDynamoDBScanExpression()
        queryExpression.limit = 20
        //queryExpression.filterExpression = "(contains(Event_Name, :event_name))"
        //queryExpression.expressionAttributeValues = [":event_name": "D"]
        
        dynamoDBObjectMapper.scan(SingleEvent.self, expression: queryExpression).continueWithExecutor(AWSExecutor.mainThreadExecutor(), withBlock: { (task:AWSTask!) -> AnyObject! in
            
            if task.result != nil {
                let paginatedOutput = task.result as! AWSDynamoDBPaginatedOutput
                for item in paginatedOutput.items as! [SingleEvent] {
                    print(item)
                    let event = Event(eventName: item.Event_Name!, eventLoc: item.Event_Location!, eventDate: NSDate(), eventPhoto: nil, eventCost: 25.00, eventLink: item.Event_Link!, eventDetails: "Stuff")
                    self.events += [event]
                    
                }
            }
            
            if ((task.error) != nil) {
                print("Error: \(task.error)")
            }
            return nil
        })

        /*for _ in 1...20 {
        let event = Event(eventName: "Comedy: Kevin Hart", eventLoc: "IMU2",eventDate: NSDate(), eventPhoto: nil, eventCost: 25.00, eventLink: "www.comedycentral.com", eventDetails: "Stand up comedy performance at the IMU")
         let event1 = Event(eventName: "Comedy: Kevin Hart", eventLoc: "IMU",eventDate: NSDate(), eventPhoto: nil, eventCost: 25.00, eventLink: "www.comedycentral.com", eventDetails: "Stand up comedy performance at the IMU")
        events += [event, event1]
        }*/
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
        cell.eventNameLabel.text = cell.event?.eventName
        cell.eventDateLabel.text = "Today"
        cell.eventImage.image = cell.event?.eventPhoto

        // Configure the cell...

        return cell
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

    

}
