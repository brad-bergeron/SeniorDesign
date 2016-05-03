//
//  EventPageViewController.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/15/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit
import EventKit


class EventPageViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: Outlets

    @IBOutlet weak var eventName: UIButton!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    
    @IBOutlet weak var eventDetails: UITextView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var eventCost: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    var currentEvent : SingleEvent!
    let eventStore = EKEventStore()
    
    // MARK: Actions
    @IBAction func moreOptions(sender: UIButton) {
        let alertController = UIAlertController(title: "More Options", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        if(!FavoritesCollectionViewController().containsEvent(currentEvent)){
            alertController.addAction(UIAlertAction(title:"Favorite", style: UIAlertActionStyle.Default, handler: { action in
                FavoritesCollectionViewController().favorites.append(self.currentEvent)
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }))
        } else {
            alertController.addAction(UIAlertAction(title:"Remove from Favorites", style: UIAlertActionStyle.Default, handler: { action in
                FavoritesCollectionViewController().removeFavorite(self.currentEvent)
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }))
        }
        
        alertController.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Cancel, handler: { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        
        
        self.presentViewController(alertController, animated: true, completion: nil)

    }
 
    @IBAction func backButton(sender: UIBarButtonItem) {
        //let viewControllers = self.navigationController!.viewControllers
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func externalLink(sender: AnyObject) {
        let alertController = UIAlertController(title: "Open Link in Safari", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title:"Open", style: UIAlertActionStyle.Default, handler: {action in
            UIApplication.sharedApplication().openURL(NSURL(string: self.currentEvent.Event_Link!)!)
        }))
        alertController.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Default, handler: { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    @IBAction func favoriteStar(sender: UIButton) {
        //create favorite capability
    }
    
    @IBAction func addCalendar(sender: UIButton) {
        let status = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
        switch (status) {
        case EKAuthorizationStatus.NotDetermined:
            requestAccessToCalendar()
        case EKAuthorizationStatus.Authorized:
            self.addToCalendar()
        case EKAuthorizationStatus.Denied, EKAuthorizationStatus.Restricted:
            print("Access Denied")
            requestAccessToCalendar()
            //self.needPermissionView.fadeIn()
        }
        
    }
    
    func addToCalendar(){
        let msg = "Event: " + currentEvent.Event_Name!
        let alertController = UIAlertController(title: "Add Event to Calendar", message: msg, preferredStyle: UIAlertControllerStyle.Alert) //add in message
        alertController.addAction(UIAlertAction(title:"Add", style: UIAlertActionStyle.Default, handler: {action in
            //add later
            self.addEvent()
        }))
        alertController.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Default, handler: { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func requestAccessToCalendar(){
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {(granted: Bool, error: NSError?) in print(granted)})
    }
    
   /* @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.sourceViewController as? EventPageViewController{
            //if anything needs to happen do here
        }
        
    }*/
    
    func addEvent() {
        let calEvent = EKEvent.init(eventStore: eventStore)
        calEvent.title = self.currentEvent.Event_Name!
        calEvent.location = self.currentEvent.Event_Location!
        calEvent.URL = NSURL(string:self.currentEvent.Event_Link!)
        calEvent.timeZone = NSTimeZone.localTimeZone()
        calEvent.calendar = self.eventStore.defaultCalendarForNewEvents
        calEvent.startDate = self.currentEvent.Event_NSDate!
        calEvent.endDate = self.currentEvent.Event_NSDate!.dateByAddingTimeInterval(60*60)
        do{
            try self.eventStore.saveEvent(calEvent, span: EKSpan.ThisEvent, commit: true)
            let alertController = UIAlertController(title: "Success!", message: currentEvent.Event_Name! + " added to calendar.", preferredStyle: UIAlertControllerStyle.Alert) //add in message
            alertController.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler: {action in alertController.dismissViewControllerAnimated(true, completion: nil)}))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        } catch {
            //add alert to error
            let alertController = UIAlertController(title: "Error adding event", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert) //add in message
            alertController.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler: {action in alertController.dismissViewControllerAnimated(true, completion: nil)}))
            self.presentViewController(alertController, animated: true, completion: nil)
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvent()
        //checkAuthorization()
        
        let scrollViewBounds = scrollView.bounds

        
        var scrollViewInsets = UIEdgeInsetsZero
        scrollViewInsets.top = scrollViewBounds.size.height/2.0;
        scrollViewInsets.top -= contentView.bounds.size.height/2.0;
        
        scrollViewInsets.bottom = scrollViewBounds.size.height/2.0
        scrollViewInsets.bottom -= contentView.bounds.size.height/2.0;
        scrollViewInsets.bottom += 1
        
        scrollView.contentInset = scrollViewInsets
        contentView.backgroundColor = UIColor.whiteColor()
        scrollView.backgroundColor = contentView.backgroundColor
        //self.eventDetails.scrollEnabled = false
        //self.scrollView.backgroundColor = UIColor.whiteColor()
        //self.scrollView.showsVerticalScrollIndicator = true
        //self.scrollView.scrollEnabled = true
        // Do any additional setup after loading he view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadEvent() -> Int{
        eventName.setTitle(currentEvent.Event_Name, forState: .Normal)
        //eventImage.image = currentEvent?.eventPhoto!
        let formatDate = NSDateFormatter()
        formatDate.dateFormat = "EEEE, MMMM dd, yyyy"
        let formatDate2 = NSDateFormatter()
        formatDate2.dateFormat = "hh:mm a"
        formatDate2.timeZone = NSTimeZone(abbreviation: "CST")
        eventDate.text = formatDate.stringFromDate(currentEvent.Event_NSDate!)
        eventTime.text = formatDate2.stringFromDate(currentEvent.Event_NSDate!)
        eventLocation.text = currentEvent.Event_Location
        eventImage.contentMode = UIViewContentMode.ScaleAspectFit
        eventImage.image = currentEvent.Event_Picture
        eventCost.text = currentEvent.Event_Price
        //add event details
        //add button for link to website*/
        return 1;
    }
    

    /*
    // MARK: - Navigation
    //MIGHT NEED RETURN SEGUE

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
