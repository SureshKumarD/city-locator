//
//  ViewController.swift
//  CityLocatorApplication
//
//  Created by Suresh on 02/12/14.
//  Copyright (c) 2014 Neev. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    let cityListArray = ["Bangalore", "Chennai", "Hyderabad", "Mumbai", "NewDelhi", "Kolkata", "Jaipur", "Truvandrum", "NewYork", "London", "Moscow", "Berlin"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "City List"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Datasource Methods
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cityListArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = self.tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath) as? UITableViewCell
        if(cell == nil){
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CellIdentifier")
            
        }
        cell.textLabel?.text = self.cityListArray[indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView Delegate Method
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("selected cell index \(indexPath.row)")
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var mapViewController = storyBoard.instantiateViewControllerWithIdentifier("mapViewController") as MapViewController
        mapViewController.cityName = self.cityListArray[indexPath.row]
        self.navigationController?.pushViewController(mapViewController, animated: true)
    }

}

