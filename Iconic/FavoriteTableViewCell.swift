//
//  FavoriteTableViewCell.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/23/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell{
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var eventCostLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    var event: SingleEvent!
    var startCenter : CGPoint?
    var favorited : Bool?

    required init?(coder aDecoder: NSCoder) {
        self.favorited = false;
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initSwipes()
        self.backgroundColor = UIColor.whiteColor()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func handleSwipe(sender: UIPanGestureRecognizer){
        if sender.state == .Began {
            startCenter = self.center
        } else if sender.state == .Changed {
            let movement = sender.translationInView(self)
            center = CGPointMake(movement.x + startCenter!.x, movement.y + startCenter!.y)
            favorited = frame.origin.x > frame.size.width / 2.0
        } else if sender.state == .Ended {
            let previousFrame = CGRect(x:0, y: frame.origin.y, width: bounds.size.width, height: bounds.size.height)
            if !favorited! {
                UIView.animateWithDuration(0.2, animations:{self.frame = previousFrame})
            }
        }
        
        
    }
    
    func initSwipes(){
        let favoriteSwipe = UIPanGestureRecognizer(target: self, action: #selector(FavoriteTableViewCell.handleSwipe(_:)))
        self.addGestureRecognizer(favoriteSwipe)
    }

}
