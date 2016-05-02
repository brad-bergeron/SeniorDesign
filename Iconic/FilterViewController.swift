//
//  FilterViewController.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/14/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    var filters: [(filterName : String, filterOptions : [String])] = [("All Events",["All Options"]), ("Event Type",["Music", "Comedy", "Education"])] //potentially string of button for filter options

    @IBOutlet weak var movieButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var comedyButton: UIButton!
    
    @IBOutlet weak var eventFilterType: UILabel!
    @IBAction func dropDownButton(sender: UIButton){
        //ADD CODE FOR CHANGING FILTER
    }
    
    var filteredEvents = [SingleEvent]()
    var unfilteredEvents = [SingleEvent]()
    
    @IBAction func movieButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            movieButton.setImage(UIImage(named: "Movie_Icon2.png")!, forState: .Normal)
            self.addMoive()
        }else {
            movieButton.setImage(UIImage(named: "Movie_Icon.png")!, forState: .Normal)
            self.removeMovie()
        }
    }
    
    @IBAction func musicButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            musicButton.setImage(UIImage(named: "Music_Icon2.png")!, forState: .Normal)
            self.addMusic()
        }else {
            musicButton.setImage(UIImage(named: "Music_Icon.png")!, forState: .Normal)
            self.removeMusic()
        }
    }
    
    @IBAction func comedyButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            comedyButton.setImage(UIImage(named: "Comedy_Icon2.png")!, forState: .Normal)
            self.addComedy()
        }else {
            comedyButton.setImage(UIImage(named: "Comedy_Icon.png")!, forState: .Normal)
            self.removeComedy()
        }
    }
    @IBAction func filterToggle(sender: UISwitch, forEvent event: UIEvent) {
        //ADD CODE FOR TURNING FILTERS ON AND OFF 
        //HAVE FILTERS AUTO TURN ON THE FIRST TIME
        //If selected than just have no filtered Events
        if (sender.selected) {
            filteredEvents.removeAll()
            //also turn all buttons to unlicked
            comedyButton.setImage(UIImage(named: "Comedy_Icon.png")!, forState: .Normal)
            musicButton.setImage(UIImage(named: "Music_Icon.png")!, forState: .Normal)
            movieButton.setImage(UIImage(named: "Movie_Icon.png")!, forState: .Normal)
        }
    }
    
    
    func initSwipes(){
        let leftSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(FilterViewController.handleSwipe(_:)))
        
        leftSwipe.edges = .Right
        view.addGestureRecognizer(leftSwipe)
    }
    
    func handleSwipe(sender: UIScreenEdgePanGestureRecognizer) {
        if(sender.edges == .Right && sender.state == .Recognized){
            dismissViewControllerAnimated(true, completion: nil)
        }
        //BREAKS AIF UNCOMMENTED
        self.performSegueWithIdentifier("LeftSwipe", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSwipes()
        //eventFilterType.text = filters[0].filterName

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Brad trying to send Filtered events back and breaks
        if segue.identifier == "LeftSwipe" {
            if let nav = segue.destinationViewController as? UINavigationController{
                if let dvc = nav.topViewController as? EventTableViewController{
                    if(self.filteredEvents.isEmpty){
                        dvc.searchedEvents = self.unfilteredEvents
                        dvc.constantFilteredEvents = self.unfilteredEvents
                        dvc.filtered = false
                    }
                    else{
                        dvc.searchedEvents = self.filteredEvents
                        dvc.constantFilteredEvents = self.filteredEvents
                        dvc.filtered = true
                    }
                }
            }
        }
    }
    
    func addMusic () {
        for event in unfilteredEvents {
            var added = false
            
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if ((filter.lowercaseString.rangeOfString("dance") != nil) || filter == ("acapella") || (filter.lowercaseString.rangeOfString("music") != nil) || filter == "jazz" || filter == "country" || (filter.lowercaseString.rangeOfString("alternative") != nil) || (filter.lowercaseString.rangeOfString("indie") != nil) || filter == "singer-songwriter" || (filter.lowercaseString.rangeOfString("folk") != nil) || (filter.lowercaseString.rangeOfString("rock") != nil) || (filter.lowercaseString.rangeOfString("blues") != nil)){
                        
                        added = true
                        filteredEvents.append(event)
                    }
                }
                
                
            }
        }
    }
    
    func removeMusic() {
        for event in unfilteredEvents {
            var added = false
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if ((filter.lowercaseString.rangeOfString("dance") != nil) || filter == ("acapella") || (filter.lowercaseString.rangeOfString("music") != nil) || filter == "jazz" || filter == "country" || (filter.lowercaseString.rangeOfString("alternative") != nil) || (filter.lowercaseString.rangeOfString("indie") != nil) || filter == "singer-songwriter" || (filter.lowercaseString.rangeOfString("folk") != nil) || (filter.lowercaseString.rangeOfString("rock") != nil) || (filter.lowercaseString.rangeOfString("blues") != nil)){
                        
                        added = true
                        filteredEvents = filteredEvents.filter { $0 != event }
                    }
                    
                }
            }
        }
        
    }
    
    func addComedy() {
        for event in unfilteredEvents {
            var added = false
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("comedy") != nil || filter.lowercaseString.rangeOfString("theatre") != nil || filter.lowercaseString.rangeOfString("literature") != nil){
                        
                        added = true
                        filteredEvents.append(event)
                    }
                    
                }
            }
        }
    }
    
    func removeComedy(){
        for event in unfilteredEvents {
            var added = false
            
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("comedy") != nil || filter.lowercaseString.rangeOfString("theatre") != nil || filter.lowercaseString.rangeOfString("literature") != nil){
                        
                        added = true
                        filteredEvents = filteredEvents.filter { $0 != event }
                    }
                    
                }
            }
        }
    }
    
    func addMoive() {
        for event in unfilteredEvents {
            var added = false
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("moive") != nil){
                        
                        added = true
                        filteredEvents.append(event)
                    }
                    
                }
            }
        }
    }
    
    func removeMovie(){
        for event in unfilteredEvents {
            var added = false
            
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("moive") != nil){
                        
                        added = true
                        filteredEvents = filteredEvents.filter { $0 != event }
                    }
                    
                }
            }
        }
    }
    

}
