//
//  ViewController.swift
//  AnthonyUsedCars
//
//  Created by A.Anthony on 9/4/19.
//  Copyright © 2019 anthony. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class UsedCarViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource {
   
    

    


    var UsedCars:[CarDataModel]?
    var CarResults = [CarDataModel]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Registering the xib
        collectionView.register(UINib(nibName: "UsedCarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "subcell")
        
        
        
        API.getCarData { (carData)
            in
            self.UsedCars = carData
            self.collectionView.reloadData()
            }
    }
    
    
    //MARK: - CollectionView
    /***************************************************************/
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UsedCars?.count ?? 0

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subcell", for: indexPath) as! UsedCarCollectionViewCell
        
        //        cell.carImage.image = UsedCars?[indexPath.row].imageURL
        cell.year.text = UsedCars?[indexPath.row].year
        cell.make.text = UsedCars?[indexPath.row].make
        cell.model.text = UsedCars?[indexPath.row].model
        cell.price.text = UsedCars?[indexPath.row].listPrice
        cell.miles.text = UsedCars?[indexPath.row].mileage
        cell.city.text = UsedCars?[indexPath.row].dealerCity
        cell.state?.text = UsedCars?[indexPath.row].dealerState
        cell.phoneNumber.text = UsedCars?[indexPath.row].dealerPhone?.toPhoneNumber()
        
        
        Alamofire.request((UsedCars?[indexPath.row].imageURL)!).responseImage { response in
            debugPrint(response)
            
            
            if let image = response.result.value {
                cell.carImage.image = image
            }
        }
        
        cell.contentView.layer.cornerRadius = 4.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        cell.layer.shadowRadius = 4.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius:
            cell.contentView.layer.cornerRadius).cgPath
        
        return cell
        
    }


}


extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1)$2-$3", options: .regularExpression, range: nil)
    }
}


