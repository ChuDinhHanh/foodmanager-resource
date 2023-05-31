//
//  MealTableViewCell.swift
//  FoodManagements2023
//
//  Created by CNTT on 5/4/23.
//  Copyright © 2023 fit.tdc. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {
    //MARK: Properties
    
    @IBOutlet weak var imgMeal: UIImageView!
    @IBOutlet weak var lblMealName: UILabel!
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
