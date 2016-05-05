//
//  FilterViewController.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/14/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    

    @IBOutlet weak var movieButton: UIButton!
    @IBOutlet weak var musicButton: UIButton!
    @IBOutlet weak var comedyButton: UIButton!
    @IBOutlet weak var ageButton: UIButton!
    @IBOutlet weak var familyButton: UIButton!
    @IBOutlet weak var educationButton: UIButton!
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
            movieSelected()
            self.addMovie()
            movieFilter = true
        }else {
            movieUnselected()
            self.removeMovie()
            movieFilter = false
        }
        updateLabel()
    }
    
    func movieSelected(){ movieButton.setImage(UIImage(named: "Movie_Icon.png")!, forState: .Normal) }
    func movieUnselected(){ movieButton.setImage(UIImage(named: "Movie_Icon2.png")!, forState: .Normal) }
    
    @IBAction func musicButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            musicSelected()
            self.addMusic()
            musicFilter = true
        }else {
            musicUnselected()
            self.removeMusic()
            musicFilter = false
        }
        updateLabel()
    }
    
    func musicSelected(){ musicButton.setImage(UIImage(named: "Music_Icon.png")!, forState: .Normal) }
    func musicUnselected(){ musicButton.setImage(UIImage(named: "Music_Icon2.png")!, forState: .Normal) }
    
    @IBAction func comedyButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            comedySelected()
            self.addComedy()
            comedyFilter = true
        }else {
            comedyUnselected()
            self.removeComedy()
            comedyFilter = false
        }
        updateLabel()
    }
    
    func comedySelected(){ comedyButton.setImage(UIImage(named: "Comedy_Icon.png")!, forState: .Normal) }
    func comedyUnselected(){ comedyButton.setImage(UIImage(named: "Comedy_Icon2.png")!, forState: .Normal) }
    
    @IBAction func familyButton(sender: UIButton) {
    
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            familySelected()
            self.addFamily()
            familyFilter = true
        }else {
            familyUnselected()
            self.removeFamily()
            familyFilter = false
        }
        updateLabel()
    }
    
    func familySelected(){ familyButton.setImage(UIImage(named: "Family_Icon.png")!, forState: .Normal) }
    func familyUnselected(){ familyButton.setImage(UIImage(named: "Family_Icon2.png")!, forState: .Normal) }
    
    @IBAction func educationButton(sender: UIButton) {
    
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            educationSelected()
            self.addEducation()
            educationFilter = true
        }else {
            educationUnselected()
            self.removeEducation()
            educationFilter = false
        }
        updateLabel()
    }
    
    func educationSelected(){ educationButton.setImage(UIImage(named: "Education_Icon.png")!, forState: .Normal) }
    func educationUnselected(){ educationButton.setImage(UIImage(named: "Education_Icon2.png")!, forState: .Normal) }
    
    @IBAction func ageButton(sender: UIButton) {
        
        sender.selected  = !sender.selected;
        
        if (sender.selected) {
            twentyOneSelected()
            self.add21()
            twentyOneFilter = true
        }else {
            twentyOneUnselected()
            self.remove21()
            twentyOneFilter = false
        }
        updateLabel()
    }
    
    func twentyOneSelected(){ ageButton.setImage(UIImage(named: "21_Icon.png")!, forState: .Normal) }
    func twentyOneUnselected(){ ageButton.setImage(UIImage(named: "21_Icon2.png")!, forState: .Normal) }
    
    
    @IBAction func onOffSwitch(sender: UISwitch) {
        
        if (sender.on){
            toggleOn()
            toggleFilter = true
            
        }else{
            toggleOff()
            toggleFilter = false
        }
        updateLabel()
    }
    
    func toggleOn(){
        movieButton.setImage(UIImage(named: "Movie_Icon2.png")!, forState: .Normal)
        musicButton.setImage(UIImage(named: "Music_Icon2.png")!, forState: .Normal)
        comedyButton.setImage(UIImage(named: "Comedy_Icon2.png")!, forState: .Normal)
        ageButton.setImage(UIImage(named: "21_Icon2.png")!, forState: .Normal)
        familyButton.setImage(UIImage(named: "Family_Icon2.png")!, forState: .Normal)
        educationButton.setImage(UIImage(named: "Education_Icon2.png")!, forState: .Normal)
        movieButton.enabled = true
        musicButton.enabled = true
        comedyButton.enabled = true
        ageButton.enabled = true
        familyButton.enabled = true
        educationButton.enabled = true
        movieButton.selected = false
        musicButton.selected = false
        comedyButton.selected = false
        ageButton.selected = false
        familyButton.selected = false
        educationButton.selected = false
    }
    
    func toggleOff(){
        movieButton.setImage(UIImage(named: "Movie_Icon2.png")!, forState: .Normal)
        musicButton.setImage(UIImage(named: "Music_Icon2.png")!, forState: .Normal)
        comedyButton.setImage(UIImage(named: "Comedy_Icon2.png")!, forState: .Normal)
        ageButton.setImage(UIImage(named: "21_Icon2.png")!, forState: .Normal)
        familyButton.setImage(UIImage(named: "Family_Icon2.png")!, forState: .Normal)
        educationButton.setImage(UIImage(named: "Education_Icon2.png")!, forState: .Normal)
        movieButton.adjustsImageWhenDisabled = false
        musicButton.adjustsImageWhenDisabled = false
        comedyButton.adjustsImageWhenDisabled = false
        ageButton.adjustsImageWhenDisabled = false
        familyButton.adjustsImageWhenDisabled = false
        educationButton.adjustsImageWhenDisabled = false
        movieButton.selected = false
        musicButton.selected = false
        comedyButton.selected = false
        ageButton.selected = false
        familyButton.selected = false
        educationButton.selected = false
        movieButton.enabled = false
        musicButton.enabled = false
        comedyButton.enabled = false
        ageButton.enabled = false
        familyButton.enabled = false
        educationButton.enabled = false
        self.removeFiltersAll()
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
        if(familyButton.selected){
            labelText += "Family Friendly, "
        }
        if(educationButton.selected){
            labelText += "Education, "
        }
        filtersShown.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor()] , forState: .Normal)
        if(labelText.characters.count > 2) {
            let text = labelText.substringToIndex(labelText.endIndex.predecessor().predecessor())
            filtersShown.title = text
        } else {
            filtersShown.title = String()
        }
    }
    @IBAction func helpMe(sender: AnyObject) {
        let alertController = UIAlertController(title: "Help", message: helpFilt, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title:"Got it!", style: UIAlertActionStyle.Default, handler: { action in
            alertController.dismissViewControllerAnimated(true, completion: nil)
        }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func initSwipes(){
        let leftSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(FilterViewController.handleSwipe(_:)))
        
        leftSwipe.edges = .Right
        view.addGestureRecognizer(leftSwipe)
    }
    
    func handleSwipe(sender: UIScreenEdgePanGestureRecognizer) {
        if(sender.edges == .Right && sender.state == .Recognized){
            dismissViewControllerAnimated(true, completion: nil)
            NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
            //self.performSegueWithIdentifier("LeftSwipe", sender: self)
        }

        //BREAKS AIF UNCOMMENTED
        //self.performSegueWithIdentifier("LeftSwipe", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSwipes()
        //Switch.onTintColor = UIColor(red: 48/255.0, green: 180/225.0, blue: 74/225.0, alpha: 1.0)
        
        //Used to determine if the Switch was on the alst time the user was on this page
        if(toggleFilter){
            toggleOn()
            Switch.on = true
        } else{
            toggleOff()
            Switch.on = false
        }
        //sets state of movie button
        if(movieFilter){
            movieSelected()
            movieButton.selected = true
        } else {
            movieUnselected()
        }
        //sets state of comedy button
        if(comedyFilter){
            comedySelected()
            comedyButton.selected = true
        } else {
            comedyUnselected()
        }
        //sets state of 21 button
        if(twentyOneFilter){
            twentyOneSelected()
            ageButton.selected = true
        } else {
            twentyOneUnselected()
        }
        //sets state of music button
        if(musicFilter){
            musicSelected()
            musicButton.selected = true
        } else {
            musicUnselected()
        }
        
        //sets state of family button
        if(familyFilter){
            familySelected()
            familyButton.selected = true
        } else {
            familyUnselected()
        }
        //sets state of education button
        if(educationFilter){
            educationSelected()
            educationButton.selected = true
        } else {
            educationUnselected()
        }
        updateLabel()
        Switch.tintColor = UIColor.grayColor()
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
        
        
    }
    
    func addMusic() {
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
        filtered = true
        seenEvents = filteredEvents
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
        checkRemove()
        
    }
    
    func addComedy() {
        for event in unfilteredEvents {
            var added = false
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("comedy") != nil || filter.lowercaseString.rangeOfString("theatre") != nil){
                        
                        added = true
                        filteredEvents.append(event)
                    }
                    
                }
            }
        }
        checkAdd()
    }
    
    func removeComedy(){
        for event in unfilteredEvents {
            var added = false
            
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("comedy") != nil || filter.lowercaseString.rangeOfString("theatre") != nil){
                        
                        added = true
                        filteredEvents = filteredEvents.filter { $0 != event }
                        
                    }
                    
                }
            }
        }
        checkRemove()
    }
    
    func addMovie() {
        for event in unfilteredEvents {
            var added = false
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("movie") != nil){
                        
                        added = true
                        filteredEvents.append(event)
                    }
                    
                }
            }
        }
        checkAdd()
    }
    
    func removeMovie(){
        for event in unfilteredEvents {
            var added = false
            
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("movie") != nil){
                        
                        added = true
                        filteredEvents = filteredEvents.filter { $0 != event }
                        
                    }
                    
                }
            }
        }
        checkRemove()
    }
    
    func add21() {
        for event in unfilteredEvents {
            var added = false
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("+21") != nil){
                        
                        added = true
                        filteredEvents.append(event)
                    }
                    
                }
            }
        }
        checkAdd()
    }
    
    func remove21(){
        for event in unfilteredEvents {
            var added = false
            
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("+21") != nil){
                        
                        added = true
                        filteredEvents = filteredEvents.filter { $0 != event }
                        
                    }
                    
                }
            }
        }
        checkRemove()
    }
    
    func addFamily() {
        for event in unfilteredEvents {
            var added = false
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("community") != nil || filter.lowercaseString.rangeOfString("family") != nil){
                        
                        added = true
                        filteredEvents.append(event)
                    }
                    
                }
            }
        }
        checkAdd()
    }
    
    func removeFamily(){
        for event in unfilteredEvents {
            print(event.Event_Name!)
            var added = false
            
            for filter in event.Event_Filters! as [String]{
                print(filter)
                if added == false{
                    if (filter.lowercaseString.rangeOfString("community") != nil || filter.lowercaseString.rangeOfString("family") != nil){
                        
                        added = true
                        filteredEvents = filteredEvents.filter { $0 != event }
                        
                    }
                    
                }
            }
        }
        checkRemove()
    }
    
    func addEducation() {
        for event in unfilteredEvents {
            var added = false
            for filter in event.Event_Filters! as [String]{
                if added == false{
                    if (filter.lowercaseString.rangeOfString("educational") != nil || filter.lowercaseString.rangeOfString("literature") != nil || filter.lowercaseString.rangeOfString("reading") != nil){
                        
                        added = true
                        filteredEvents.append(event)
                    }
                    
                }
            }
        }
        checkAdd()
    }

    func removeEducation(){
        for event in unfilteredEvents {
            print(event.Event_Name!)
            var added = false
            
            for filter in event.Event_Filters! as [String]{
                print(filter)
                if added == false{
                    if (filter.lowercaseString.rangeOfString("educational") != nil || filter.lowercaseString.rangeOfString("literature") != nil || filter.lowercaseString.rangeOfString("reading") != nil){
                        
                        added = true
                        filteredEvents = filteredEvents.filter { $0 != event }
                        
                    }
                    
                }
            }
        }
        checkRemove()
    }
    
    
    
    func checkRemove(){
        if filteredEvents.isEmpty{
            filtered = false
            seenEvents = unfilteredEvents
        }
        else{
            filtered = true
            seenEvents = filteredEvents
        }
    }
    
    func checkAdd(){
        filtered = true
        seenEvents = filteredEvents
    }
    
    func removeFiltersAll(){
        filteredEvents.removeAll()
        movieFilter = false
        musicFilter = false
        twentyOneFilter = false
        educationFilter = false
        comedyFilter = false
        familyFilter = false
        checkRemove()
    }
    
    

}
