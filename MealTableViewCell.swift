//
//  @Name: MealTableViewCell.swift
//  @Purpose: To update the table views in the starting screen of the app.
//  FoodTracker
//
//  Created by Pratheeksha Ravindra Naik on 2018-09-28.
//  Copyright © 2018 com/uregina. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    //MARK: properties - creating outlets
    
    @IBOutlet weak var nameLabel: UILabel!  //Creates outlet for the Name Label
    
    @IBOutlet weak var photoImageView: UIImageView! //Creates outlet for the Photo Image View.
    
    @IBOutlet weak var ratingControl: RatingControl! //Creates outlet for the Rating.
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
