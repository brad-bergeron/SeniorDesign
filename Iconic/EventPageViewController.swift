//
//  EventPageViewController.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/15/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit
import EventKit
import MapKit
import Foundation


class EventPageViewController: UIViewController, UIScrollViewDelegate, MKMapViewDelegate{
    
    // MARK: Outlets

    @IBOutlet weak var eventName: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var eventDetails: UITextView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var eventCost: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    var currentEvent : SingleEvent!
    let eventStore = EKEventStore()
    
    @IBOutlet weak var favoritesButton: UIButton!
    let defaultLat = 41.661922
    let defaultLong = -91.535682
    
    
    let regionRadius : CLLocationDistance = 1000
    
    
    @IBAction func favButtonSwitch(sender: UIButton) {
        sender.selected = !sender.selected;
        
        if(sender.selected) {
            favoritesButton.setImage(UIImage(named: "StarFilled.png")!, forState: .Normal)
        } else {
            favoritesButton.setImage(UIImage(named: "Star.png")!, forState: .Normal)
        }
    }
    
    
    @IBAction func helpMe(sender: AnyObject) {
        let alertController = UIAlertController(title: "Help", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title:"Got it!", style: UIAlertActionStyle.Default, handler: { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))

        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    // MARK: Actions
    @IBAction func moreOptions(sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        if(!favorites.contains(currentEvent)){
            alertController.addAction(UIAlertAction(title:"Favorite", style: UIAlertActionStyle.Default, handler: { action in
                favorites.append(self.currentEvent)
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }))
        } else {
            alertController.addAction(UIAlertAction(title:"Remove from Favorites", style: UIAlertActionStyle.Default, handler: { action in
                favorites.removeAtIndex(favorites.indexOf(self.currentEvent)!)
                alertController.dismissViewControllerAnimated(true, completion: nil)
            }))
        }
        alertController.addAction(UIAlertAction(title:"Notify me!", style: UIAlertActionStyle.Default, handler: { action in
            self.scheduleNotification()
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        alertController.addAction(UIAlertAction(title:"Open Link in Safari", style: UIAlertActionStyle.Default, handler: { action in
            self.externalLink()
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title:"Add to Calendar", style: UIAlertActionStyle.Default, handler: { action in
            self.addCalendar()
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title:"Share", style: UIAlertActionStyle.Default, handler: { action in
            self.shareEvent()
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))

        
        alertController.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Cancel, handler: { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        
        
        self.presentViewController(alertController, animated: true, completion: nil)

    }
 
    @IBAction func backButton(sender: UIBarButtonItem) {
        //let viewControllers = self.navigationController!.viewControllers
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func externalLink() {
        //Code for going to a URL starts Here
        let alertController = UIAlertController(title: "Open Link in Safari", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title:"Open", style: UIAlertActionStyle.Default, handler: {action in
            UIApplication.sharedApplication().openURL(NSURL(string: self.currentEvent.Event_Link!)!)
        }))
        alertController.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Default, handler: { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        //Code for going to a URL end Here
        
        
    }
    
    func shareEvent(){
        //Code for sharing link starts here
        let punctuation = NSCharacterSet(charactersInString: "?.,!@-:–")
        
        let tokens = self.currentEvent.Event_Name!.componentsSeparatedByCharactersInSet(punctuation)
        let compare = tokens.joinWithSeparator("")
        
        
        let lowerString = compare.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        
        let txtToShare = "Hey Check out this event in Iowa City!"
        
        let url = "gfIconic://event/"+lowerString
        
        print(url)
        
        if let myApp = NSURL(string: url) {
            let objectToShare = [txtToShare,myApp]
            let activityVC = UIActivityViewController(activityItems: objectToShare, applicationActivities: nil)
            
            self.presentViewController(activityVC, animated: true, completion: nil)
            
        }
        //code for sharing link ends here
    }
    
    
    @IBAction func favoriteStar(sender: UIButton) {
        //create favorite capability
    }
    
    func addCalendar() {
        let status = EKEventStore.authorizationStatusForEntityType(EKEntityType.Event)
        switch (status) {
        case EKAuthorizationStatus.NotDetermined:
            requestAccessToCalendar()
            if(EKEventStore.authorizationStatusForEntityType(EKEntityType.Event) == EKAuthorizationStatus.Authorized){
                self.addToCalendar()
            }
        case EKAuthorizationStatus.Authorized:
            self.addToCalendar()
        case EKAuthorizationStatus.Denied, EKAuthorizationStatus.Restricted:
            print("Access Denied")
            deniedPermission()            //self.needPermissionView.fadeIn()
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
    
    func deniedPermission(){
        let alertController = UIAlertController(title: "Access to Calendar Denied", message: "The event cannot be added because access to Calendar is disabled. Change the settings for ICONIC to add the event", preferredStyle: UIAlertControllerStyle.Alert) //add in message
        alertController.addAction(UIAlertAction(title:"Go to Settings", style: UIAlertActionStyle.Default, handler: {action in
            //add later
            if let settingsURL = NSURL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.sharedApplication().openURL(settingsURL)
            } else {
                print("error")
            }
        }))
        alertController.addAction(UIAlertAction(title:"Cancel", style: UIAlertActionStyle.Default, handler: { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
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
    
    
    
    // MARK: Notification 
    
    func scheduleNotification(){
        let notification = UILocalNotification()
        notification.fireDate = currentEvent.Event_NSDate!.dateByAddingTimeInterval(-1*24*60*60)
        //notification.fireDate = NSDate().dateByAddingTimeInterval(60)
        notification.alertBody = currentEvent.Event_Name! + " is tomorrow!"
        notification.alertAction = "See you there"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        let alertController = UIAlertController(title: "Success!", message: "Notification for " + currentEvent.Event_Name! + " will occur one day before.", preferredStyle: UIAlertControllerStyle.Alert) //add in message
        alertController.addAction(UIAlertAction(title:"OK", style: UIAlertActionStyle.Default, handler: {action in alertController.dismissViewControllerAnimated(true, completion: nil)}))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvent()
        //checkAuthorization()
        
        let defaultLocation = CLLocation(latitude: defaultLat, longitude: defaultLong)
        
        centerMap(defaultLocation)
        let annotation = MapPin(coordinate: CLLocationCoordinate2D(latitude: defaultLat, longitude: defaultLong), title: self.currentEvent.Event_Name!, subtitle: self.currentEvent.Event_Location!)
        mapView.addAnnotation(annotation)
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
        
        
        // MARK: Maps
        
        
        
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
    
    // MARK: LAT
    func centerMap(location: CLLocation){
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, self.regionRadius*2.0, self.regionRadius*2.0)
            self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadEvent() -> Int{
        
        eventName.text = currentEvent.Event_Name
        //eventImage.image = currentEvent?.eventPhoto!
        let formatDate = NSDateFormatter()
        formatDate.dateFormat = "EEEE, MMMM dd, yyyy"
        let formatDate2 = NSDateFormatter()
        formatDate2.dateFormat = "hh:mm a"
        formatDate2.timeZone = NSTimeZone(abbreviation: "CST")
        eventDate.text = formatDate.stringFromDate(currentEvent.Event_NSDate!)
        eventTime.text = formatDate2.stringFromDate(currentEvent.Event_NSDate!)
        if(currentEvent.Event_Location == poorString){
            eventLocation.text = "Iowa Memorial Union (CAB)"
        } else {
            eventLocation.text = currentEvent.Event_Location
        }
        //print(eventLocation)
        //eventImage.contentMode = UIViewContentMode.ScaleAspectFit
        eventImage.image = currentEvent.Event_Picture
        eventCost.text = currentEvent.Event_Price
        //add event details
        //add button for link to website*/
        return 1;
    }
    
    func mapView(mapView: MKMapView!, annotationView: MKAnnotation!) -> MKAnnotationView! {
        let identifier = "pin"
        var view : MKPinAnnotationView
        if let dequeView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView {
            dequeView.annotation = annotationView
            view = dequeView
        }
        else {
            // 3
            view = MKPinAnnotationView(annotation: annotationView, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
        }
        return view
    }
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


