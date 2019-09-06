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

class UsedCarViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UISearchBarDelegate , UISearchResultsUpdating , UISearchControllerDelegate {
   
    

    


    var UsedCars:[CarDataModel]?
    var CarResults = [CarDataModel]()
    var filteredCars = [CarDataModel]()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Registering the xib
        collectionView.register(UINib(nibName: "UsedCarCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "subcell")
        
        
        setupSearchController()
        
        
        API.getCarData { (carData)
            in
            self.UsedCars = carData
            print("This is the Results \(self.UsedCars?.count ?? 0)")
            self.collectionView.reloadData()
            self.createbarbutton()

    }

    }
    
    
    
    //MARK: - SearchBar
    /***************************************************************/
    
    func setupSearchController() {
        
        //         Adds the searchbar to the navigation header
        
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search by Year"
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.sizeToFit()
        //        tableView.tableHeaderView = searchController.searchBar
        
        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            textfield.tintColor = UIColor.black
            textfield.font = UIFont(name: "Helvetica Neue", size: 13)
            if let backgroundview = textfield.subviews.first {
                
                backgroundview.backgroundColor = UIColor.white
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
    }
    
    func filterRowsForSearchedText(_ searchText: String) {
        
        filteredCars = UsedCars!.filter({ (cars : CarDataModel ) -> Bool in
            return (cars.year?.lowercased().contains(searchText.lowercased()) ?? false)
        })

        self.collectionView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            filterRowsForSearchedText(text)
        }
        collectionView.reloadData()
        createbarbutton()
    }
    
    func isfiltering() -> Bool {
        return  searchController.isActive && searchController.searchBar.text != ""
    }
    
    
    // Function to display number of search results
    
    func createbarbutton () {
        
        if isfiltering() {
            //Create Right navigation button
            let LeftBarButton = UIBarButtonItem(title: "Results:\(self.filteredCars.count)", style: UIBarButtonItem.Style.plain, target: self, action: nil)
            LeftBarButton.tintColor = UIColor.white
            self.navigationItem.rightBarButtonItem = LeftBarButton
        }
        else {
            let LeftBarButton = UIBarButtonItem(title: "Results:\(self.UsedCars?.count ?? 0)", style: UIBarButtonItem.Style.plain, target: self, action: nil)
            LeftBarButton.tintColor = UIColor.white
            self.navigationItem.rightBarButtonItem = LeftBarButton
        }
    }
    
    
    //MARK: - CollectionView
    /***************************************************************/
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isfiltering() {
            return filteredCars.count
        }
        else {
            return UsedCars?.count ?? 0
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "subcell", for: indexPath) as! UsedCarCollectionViewCell
        
        cell.carImage.image = nil
        
        if isfiltering() {

            cell.year.text = filteredCars[indexPath.row].year
            cell.make.text = filteredCars[indexPath.row].make
            cell.model.text = filteredCars[indexPath.row].model
            cell.price.text = filteredCars[indexPath.row].listPrice
            cell.miles.text = filteredCars[indexPath.row].mileage
            cell.city.text = filteredCars[indexPath.row].dealerCity
            cell.state?.text = filteredCars[indexPath.row].dealerState
            cell.phoneNumber.text = filteredCars[indexPath.row].dealerPhone?.toPhoneNumber()

            Alamofire.request(filteredCars[indexPath.row].imageURL ?? "").responseImage { response in
                debugPrint(response)

                if let image = response.result.value {
                    cell.carImage.image = image
                }
            }
        }
            

        else {
            cell.year.text = UsedCars?[indexPath.row].year
            cell.make.text = UsedCars?[indexPath.row].make
            cell.model.text = UsedCars?[indexPath.row].model
            cell.price.text = UsedCars?[indexPath.row].listPrice
            cell.miles.text = UsedCars?[indexPath.row].mileage
            cell.city.text = UsedCars?[indexPath.row].dealerCity
            cell.state?.text = UsedCars?[indexPath.row].dealerState
            cell.phoneNumber.text = UsedCars?[indexPath.row].dealerPhone?.toPhoneNumber()
      
            Alamofire.request(UsedCars?[indexPath.row].imageURL ?? "").responseImage { response in
                debugPrint(response)
                
                if let image = response.result.value {
                    cell.carImage.image = image
                }
            }
        }
        
        if cell.carImage.image == nil {
            cell.carImage.image = UIImage(named: "noImage")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedCar:CarDataModel
        
        if isfiltering() {
            selectedCar = filteredCars[indexPath.row]
            performSegue(withIdentifier: "cardetails", sender: selectedCar)

        }
        else {
            selectedCar = UsedCars![indexPath.row]
            performSegue(withIdentifier: "cardetails", sender: selectedCar)
            print("This is the selected Row \(selectedCar.listPrice ?? "")")
            
        }
        

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let vc = segue.destination as? CarDetailViewController {
                vc.UsedCars = sender as? CarDataModel
    }
    }
    
    
}


extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1)$2-$3", options: .regularExpression, range: nil)
    }
}


