//
//  CarDetailViewController.swift
//  AnthonyUsedCars
//
//  Created by A.Anthony on 9/5/19.
//  Copyright © 2019 anthony. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class CarDetailViewController: UIViewController {

    var UsedCars:CarDataModel?

    @IBOutlet weak var aview: UIView!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var make: UILabel!
    @IBOutlet weak var model: UILabel!
    @IBOutlet weak var miles: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        price.text = UsedCars?.listPrice
        year.text = UsedCars?.year
        make.text = UsedCars?.make
        model.text = UsedCars?.model
        miles.text = UsedCars?.mileage
        
        Alamofire.request((UsedCars?.imageURL)!).responseImage { response in
            debugPrint(response)
            
            
            if let image = response.result.value {
                self.carImage.image = image
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
