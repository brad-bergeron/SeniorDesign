//
//  FavoritesCollectionViewController.swift
//  Iconic
//
//  Created by Alexis Burnight on 5/2/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FavoriteCollectionCell"

class FavoritesCollectionViewController: UICollectionViewController {
    
    var sendEvent : SingleEvent?
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        initSwipes()
        
        //Inlitizes Search bar for favorites. We didnt actually add the search bar to view but 
        //the logic is here too
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        
        //If teh user doesnt have any favorite  this alerts them of such
        if(favorites.isEmpty){
            let alertController = UIAlertController(title: "Oops!", message: "You have no favorites.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title:"Dismiss", style: UIAlertActionStyle.Default, handler: { action in
                alertController.navigationController?.popViewControllerAnimated(true)
            }))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Intilizes the swipes
    func initSwipes() {
        
        let rightswipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(FavoritesCollectionViewController.handleSwipe(_:)))
        
        rightswipe.edges = .Left

        view.addGestureRecognizer(rightswipe)
    }
    
    //handles when the user swipes to another view
    func handleSwipe(sender: UIPanGestureRecognizer) {
        if let edge = sender as? UIScreenEdgePanGestureRecognizer{
            if (edge.edges == .Left && sender.state == .Recognized){
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    //handles if a user wants to go to ta specifc event page
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FavoriteDetailsSegue" {
            if let nav = segue.destinationViewController as? UINavigationController{
                if let dvc = nav.topViewController as? EventPageViewController{
                    dvc.currentEvent = self.sendEvent
                }
            }
        }
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return favorites.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! FavoriteCollectionViewCell
        cell.EventName.text = searchedFavorites[indexPath.row].Event_Name!
        // Configure the cell
        if(favorites[indexPath.row].Event_Picture != nil){
            cell.EventImage.image = searchedFavorites[indexPath.row].Event_Picture!
        }
    
        return cell
    }
    
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        self.sendEvent = searchedFavorites[indexPath.row]
        self.performSegueWithIdentifier("FavoriteDetailsSegue", sender: self)
        return true
    }
    

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return true
    }
    
    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
        self.sendEvent = searchedFavorites[indexPath.row]
        self.performSegueWithIdentifier("FavoriteDetailsSegue", sender: self)
    }
    
    //This handles if the user is searching it will filter from the array
    func filterContentForSearchText(searchText: String, scope: String = "All"){
        if(searchText.isEmpty) {
            searchedFavorites = favorites
        } else {
            searchedFavorites = favorites.filter { SingleEvent in
                return SingleEvent.Event_Name!.lowercaseString.containsString(searchText.lowercaseString)
            }
        }
        
        
        searchedFavorites.sortInPlace({ $0.Event_NSDate!.compare($1.Event_NSDate!) == NSComparisonResult.OrderedAscending })
        self.collectionView?.reloadData()
        
        
    }

    

}

//An Extension so wheneevr the search abr updates this function is called
extension FavoritesCollectionViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
        
    }
}
