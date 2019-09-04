//
//  UsedCarCollectionViewCell.swift
//  AnthonyUsedCars
//
//  Created by A.Anthony on 9/4/19.
//  Copyright © 2019 anthony. All rights reserved.
//

import UIKit

class UsedCarCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var make: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var seperator1: UILabel!
    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var seperator2: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var phoneNumber: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
