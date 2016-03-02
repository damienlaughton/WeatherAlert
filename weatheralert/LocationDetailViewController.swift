//
//  LocationDetailViewController.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class LocationDetailViewController: RootViewController {
  
  @IBOutlet weak var detailsUITableView: UITableView!
  
  var selectedLocation: Location? = .None
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
  }
}
