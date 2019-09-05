//
//  CarDetailViewController.swift
//  AnthonyUsedCars
//
//  Created by A.Anthony on 9/5/19.
//  Copyright © 2019 anthony. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController {

    var UsedCars:CarDataModel?

    @IBOutlet weak var price: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        price.text = UsedCars?.listPrice

        // Do any additional setup after loading the view.
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
