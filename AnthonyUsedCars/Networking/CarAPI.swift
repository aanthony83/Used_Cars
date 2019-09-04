//
//  CarAPI.swift
//  AnthonyUsedCars
//
//  Created by A.Anthony on 9/4/19.
//  Copyright © 2019 anthony. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit



class API {
    
    // API
    
    
    static let carURL = "https://carfax-for-consumers.firebaseio.com/assignment.json"
    
    
    // Function to get used car data
    
    static func getCarData(completionHandler: @escaping ([CarDataModel]) -> Void) {
        
        Alamofire.request(carURL , method: .get).responseJSON {
            response  in
            
            if response.result.isSuccess {
                let CarDataJson :JSON = JSON(response.result.value)
                
                print(CarDataJson)
                
                let entries = CarDataJson["listings"].arrayValue

                
                var carData = [CarDataModel]()
                
                for entry in entries {

                
                let imageURL = entry["images"]["medium"][0].stringValue + ".jpg"
                let year = entry["year"].stringValue
                let make = entry["make"].stringValue
                let model = entry["model"].stringValue
                let trim = entry["trim"].stringValue
                let price = entry["listPrice"].stringValue
                let mileage = entry["mileage"].stringValue + "k " + "Mi"
                let dealerCity = entry["dealer"]["city"].stringValue + ","
                let dealerState = entry["dealer"]["state"].stringValue
                let dealerPhone = entry["dealer"]["phone"].stringValue
                
                
                let carInfo = CarDataModel(imageURL: imageURL, year: year, make: make, model: model, trim: trim, listPrice: price, mileage: mileage, dealerCity: dealerCity, dealerState: dealerState, dealerPhone: dealerPhone)
                
                carData.append(carInfo)
                }
                completionHandler(carData)
                
            }
                
            else {
                print("Error: \(String(describing: response.result.error))")
                
            }
            
            
            
        }
        
 
    }
    
}




