//
//  EventPageViewController.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/15/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class EventPageViewController: UIViewController {
    
    // MARK: Outlets

    @IBOutlet weak var eventName: UIButton!
    
    
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventDetails: UITextView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var eventCost: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    var currentEvent : SingleEvent!
    
    // MARK: Actions
 
    @IBAction func backButton(sender: UIBarButtonItem) {
        //let viewControllers = self.navigationController!.viewControllers
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func favoriteStar(sender: UIButton) {
        //create favorite capability
    }
    
   /* @IBAction func unwindToViewController(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.sourceViewController as? EventPageViewController{
            //if anything needs to happen do here
        }
        
    }*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvent()
        self.eventDetails.scrollEnabled = false
        self.scrollView.backgroundColor = UIColor.whiteColor()
        self.scrollView.scrollEnabled = true
        // Do any additional setup after loading he view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadEvent() -> Int{
        eventName.titleLabel!.text = currentEvent.Event_Name
        //eventImage.image = currentEvent?.eventPhoto!
        eventDate.text = "FILL IN LATER"
        eventTime.text = "FILL IN LATER"
        eventLocation.text = currentEvent.Event_Location
        //eventCost.text = currentEvent?.eventCost!
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
