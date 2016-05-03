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
    @IBOutlet weak var Switch: UISwitch!

    @IBOutlet weak var eventFilterType: UILabel!
    @IBOutlet weak var filtersShown: UIBarButtonItem!
    @IBOutlet weak var filterSwitch: UIBarButtonItem!

    var labelText = String()

    
    @IBAction func dropDownButton(sender: UIButton){
        //ADD CODE FOR CHANGING FILTER
    }

    
    var unfilteredEvents = [SingleEvent]()
    
    @IBAction func movieButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            movieButton.setImage(UIImage(named: "Movie_Icon.png")!, forState: .Normal)
            self.addMovie()
        }else {
            movieButton.setImage(UIImage(named: "Movie_Icon2.png")!, forState: .Normal)
            self.removeMovie()
        }
        updateLabel()
    }
    
    @IBAction func musicButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            musicButton.setImage(UIImage(named: "Music_Icon.png")!, forState: .Normal)
            self.addMusic()
        }else {
            musicButton.setImage(UIImage(named: "Music_Icon2.png")!, forState: .Normal)
            self.removeMusic()
        }
        updateLabel()
    }
    
    @IBAction func comedyButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            comedyButton.setImage(UIImage(named: "Comedy_Icon.png")!, forState: .Normal)
            self.addComedy()
        }else {
            comedyButton.setImage(UIImage(named: "Comedy_Icon2.png")!, forState: .Normal)
            self.removeComedy()
        }
        updateLabel()
    }
    
    @IBAction func ageButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            ageButton.setImage(UIImage(named: "21_Icon.png")!, forState: .Normal)
            self.addComedy()
        }else {
            ageButton.setImage(UIImage(named: "21_Icon2.png")!, forState: .Normal)
            self.removeComedy()
        }
        updateLabel()
    }
    
    
    @IBAction func onOffSwitch(sender: UISwitch) {
        
        if (sender.on){
            movieButton.setImage(UIImage(named: "Movie_Icon.png")!, forState: .Normal)
            musicButton.setImage(UIImage(named: "Music_Icon.png")!, forState: .Normal)
            comedyButton.setImage(UIImage(named: "Comedy_Icon.png")!, forState: .Normal)
            ageButton.setImage(UIImage(named: "21_Icon.png")!, forState: .Normal)
            movieButton.enabled = true
            musicButton.enabled = true
            comedyButton.enabled = true
            ageButton.enabled = true
            movieButton.selected = true
            musicButton.selected = true
            comedyButton.selected = true
            ageButton.selected = true
        } else {
            movieButton.setImage(UIImage(named: "Movie_Icon2.png")!, forState: .Normal)
            musicButton.setImage(UIImage(named: "Music_Icon2.png")!, forState: .Normal)
            comedyButton.setImage(UIImage(named: "Comedy_Icon2.png")!, forState: .Normal)
            ageButton.setImage(UIImage(named: "21_Icon2.png")!, forState: .Normal)
            movieButton.adjustsImageWhenDisabled = false
            musicButton.adjustsImageWhenDisabled = false
            comedyButton.adjustsImageWhenDisabled = false
            ageButton.adjustsImageWhenDisabled = false
            movieButton.selected = false
            musicButton.selected = false
            comedyButton.selected = false
            ageButton.selected = false
            movieButton.enabled = false
            musicButton.enabled = false
            comedyButton.enabled = false
            ageButton.enabled = false
            
        }
        updateLabel()
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
    
    func updateLabel(){
        labelText = String()
        if(movieButton.selected){
            labelText += "Movies, "
        }
        if(musicButton.selected){
            labelText += "Music, "
        }
        if(comedyButton.selected){
            labelText += "Comedies, "
        }
        if(ageButton.selected){
            labelText += "Over 21, "
        }
        filtersShown.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()] , forState: .Normal)
        if(labelText.characters.count > 2) {
            let text = labelText.substringToIndex(labelText.endIndex.predecessor().predecessor())
            filtersShown.title = text
        } else {
            filtersShown.title = String()
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
        Switch.onTintColor = UIColor(red: 48/255.0, green: 180/225.0, blue: 74/225.0, alpha: 1.0)
        //Switch.tintColor = UIColor.grayColor()
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
