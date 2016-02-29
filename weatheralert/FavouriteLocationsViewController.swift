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
  @IBOutlet weak var titleUILabel: UILabel!
  @IBOutlet weak var addButtonTrailingNSLayoutConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    animateAddButton(offset:0.0, duration:0.25, delay:1.0)
    
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
  
//  MARK: - Animation(s)
  
  func animateAddButton(offset newOffset: CGFloat, duration:NSTimeInterval, delay: NSTimeInterval, completionHandler:AnimationCompletionHandler = {}) {
    
      addButtonTrailingNSLayoutConstraint.constant = newOffset
    
      UIView.animateWithDuration(duration, delay: delay, options: .CurveEaseInOut, animations: {
      
        self.view.layoutIfNeeded()
        
      }, completion: { finished in
          
        completionHandler()
    })
  }
  
//  MARK: - IBAction(s)

  @IBAction func addLocation(sender: UIButton) {
    animateAddButton(offset:-6.0, duration:0.05, delay:0.0, completionHandler:{AnimationCompletionHandler in
      self.animateAddButton(offset:0.0, duration:0.1, delay:0.0, completionHandler:{AnimationCompletionHandler in
        
//        add location here
        
        
      })
    })

  }


}




