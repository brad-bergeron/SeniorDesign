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

    
    @IBOutlet weak var eventFilterType: UILabel!
    @IBAction func dropDownButton(sender: UIButton){
        //ADD CODE FOR CHANGING FILTER
    }
    @IBAction func filterToggle(sender: UISwitch, forEvent event: UIEvent) {
        //ADD CODE FOR TURNING FILTERS ON AND OFF 
        //HAVE FILTERS AUTO TURN ON THE FIRST TIME
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
        //self.performSegueWithIdentifier("LeftSwipe", sender: self)
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
        
        //send filter data back
    }
    

}
