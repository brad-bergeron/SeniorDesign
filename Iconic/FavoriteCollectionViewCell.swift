//
//  FavoriteCollectionViewCell.swift
//  Iconic
//
//  Created by Alexis Burnight on 5/2/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class FavoriteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var EventName: UILabel!
    @IBOutlet weak var EventImage: UIImageView!
    var favorited : Bool
    
    required init?(coder aDecoder: NSCoder) {
        self.favorited = false;
        super.init(coder: aDecoder)
    }
    
}
