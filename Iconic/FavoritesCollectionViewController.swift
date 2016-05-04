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

    override func viewDidLoad() {
        super.viewDidLoad()
        initSwipes()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initSwipes() {
        //let leftswipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
        let rightswipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(FavoritesCollectionViewController.handleSwipe(_:)))
        //leftswipe.direction = .Left
        rightswipe.edges = .Left
        
        
        //view.addGestureRecognizer(leftswipe)
        view.addGestureRecognizer(rightswipe)
    }
    
    func handleSwipe(sender: UIPanGestureRecognizer) {
        if let edge = sender as? UIScreenEdgePanGestureRecognizer{
            if (edge.edges == .Left && sender.state == .Recognized){
                dismissViewControllerAnimated(true, completion: nil)
            }
        }
        //else if (sender.direction == .Right) {
        //    performSegueWithIdentifier("RightSwipe", sender: self)
        
        //}
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FavoriteDetailsSegue" {
            if let nav = segue.destinationViewController as? UINavigationController{
                if let dvc = nav.topViewController as? EventPageViewController{
                    dvc.currentEvent = self.sendEvent
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

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
        cell.EventName.text = favorites[indexPath.row].Event_Name!
        // Configure the cell
        if(favorites[indexPath.row].Event_Picture != nil){
            cell.EventImage.image = favorites[indexPath.row].Event_Picture!
        }
        cell.backgroundColor = UIColor.whiteColor()
    
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
        self.sendEvent = favorites[indexPath.row]
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
        self.sendEvent = favorites[indexPath.row]
        self.performSegueWithIdentifier("FavoriteDetailsSegue", sender: self)
    }
    

    

}
