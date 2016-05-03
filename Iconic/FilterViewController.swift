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
    @IBOutlet weak var ageButton: UIButton!
    
    @IBOutlet weak var eventFilterType: UILabel!
    @IBAction func dropDownButton(sender: UIButton){
        //ADD CODE FOR CHANGING FILTER
    }

    
    var unfilteredEvents = [SingleEvent]()
    
    @IBAction func movieButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            movieButton.setImage(UIImage(named: "Movie_Icon2.png")!, forState: .Normal)
            EventTableViewController().addMovie(unfilteredEvents)
        }else {
            movieButton.setImage(UIImage(named: "Movie_Icon.png")!, forState: .Normal)
            EventTableViewController().removeMovie()
        }
    }
    
    @IBAction func musicButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            musicButton.setImage(UIImage(named: "Music_Icon2.png")!, forState: .Normal)
           EventTableViewController().addMusic()
        }else {
            musicButton.setImage(UIImage(named: "Music_Icon.png")!, forState: .Normal)
            EventTableViewController().removeMusic()
        }
    }
    
    @IBAction func comedyButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            comedyButton.setImage(UIImage(named: "Comedy_Icon2.png")!, forState: .Normal)
            EventTableViewController().addComedy()
        }else {
            comedyButton.setImage(UIImage(named: "Comedy_Icon.png")!, forState: .Normal)
            EventTableViewController().removeComedy()
        }
    }
    
    @IBAction func ageButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            ageButton.setImage(UIImage(named: "21_Icon2.png")!, forState: .Normal)
            EventTableViewController().addComedy()
        }else {
            ageButton.setImage(UIImage(named: "21_Icon.png")!, forState: .Normal)
            EventTableViewController().removeComedy()
        }
    }
    
    @IBAction func filterToggle(sender: UISwitch, forEvent event: UIEvent) {
        //ADD CODE FOR TURNING FILTERS ON AND OFF 
        //HAVE FILTERS AUTO TURN ON THE FIRST TIME
        //If selected than just have no filtered Events
        if (sender.selected) {
            EventTableViewController().removeFiltersAll()
            //also turn all buttons to unlicked
            comedyButton.setImage(UIImage(named: "Comedy_Icon.png")!, forState: .Normal)
            musicButton.setImage(UIImage(named: "Music_Icon.png")!, forState: .Normal)
            movieButton.setImage(UIImage(named: "Movie_Icon.png")!, forState: .Normal)
            ageButton.setImage(UIImage(named: "21_Icon.png")!, forState: .Normal)
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
            //self.performSegueWithIdentifier("LeftSwipe", sender: self)
        }
        //BREAKS AIF UNCOMMENTED
        //self.performSegueWithIdentifier("unwindToEventTable", sender: self)
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
        // /*Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Brad trying to send Filtered events back and breaks
        if segue.identifier == "unwindToEventTable" {
            if let nav = segue.destinationViewController as? UINavigationController{
                if let dvc = nav.topViewController as? EventTableViewController{
                    /*if(self.filteredEvents.isEmpty){
                        dvc.searchedEvents = self.unfilteredEvents
                        dvc.constantFilteredEvents = self.unfilteredEvents
                        dvc.filtered = false
                    }
                    else{
                        dvc.searchedEvents = self.filteredEvents
                        dvc.constantFilteredEvents = self.filteredEvents
                        dvc.filtered = true
                    }*/
                }
            }
        }
    }
    
    
    

}
