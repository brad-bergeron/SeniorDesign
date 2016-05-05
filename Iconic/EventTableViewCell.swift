//
//  EventTableViewCell.swift
//  Iconic
//
//  Created by Alexis Burnight on 3/5/16.
//  Copyright © 2016 Sam Johnson. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    var event : SingleEvent!
    
    @IBOutlet weak var borderView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
