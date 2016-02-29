//
//  FavouriteLocationsViewController.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class FavouriteLocationsViewController: RootUIViewController {
  
  @IBOutlet weak var locationsUITableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  // MARK: - UITableViewDataSource Method(s)
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    var numberOfRowsInSection: Int = 2
    
    return numberOfRowsInSection
  }
  
  func location(indexPath: NSIndexPath) -> Location? {
  
  return Location()
  
//    var location : Location? = .None
//    
//
//    
//    return location
  }
  
  func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    
    let heightForRowAtIndexPath: CGFloat = 54.0
    
    return heightForRowAtIndexPath
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
      var cell = tableView.dequeueReusableCellWithIdentifier("LocationUITabelViewCell") as! LocationUITabelViewCell!
      
      if (nil == cell) {
        tableView.registerClass(LocationUITabelViewCell.classForCoder(), forCellReuseIdentifier: "LocationUITabelViewCell")
        
        cell = LocationUITabelViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "LocationUITabelViewCell")
      }
      
      if let location = location(indexPath) {
        cell.configure(location)
      }
      
    
    
      return cell
      
    }
  
  

}

