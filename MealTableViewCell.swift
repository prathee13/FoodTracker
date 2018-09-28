//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-28.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //MARK: properties - creating outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
