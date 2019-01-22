//
//  RecipeTableViewCell.swift
//  Linner
//
//  Created by C4Q on 1/22/19.
//  Copyright © 2019 Iram Fattah. All rights reserved.
//

import UIKit

    class RecipeTableViewCell: UITableViewCell {
        
        @IBOutlet weak var nameLabel: UILabel!
        @IBOutlet weak var descriptionLabel: UILabel!
        @IBOutlet weak var foodImage: UIImageView!
        
        override func awakeFromNib() {
            super.awakeFromNib()
            
            foodImage.layer.cornerRadius = 16
            foodImage.clipsToBounds = true
        }
        
}
