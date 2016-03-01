//
//  AddLocationViewController.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class AddLocationViewController: RootViewController {

  @IBOutlet weak var nameUITextField: UITextField!
  @IBOutlet weak var countryUITextField: UITextField!
  @IBOutlet weak var addLocationButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    enableDisableAddLabelButton(self)
  }
  
  @IBAction func enableDisableAddLabelButton (sender: AnyObject) {
    var nameFieldHasText: Bool = false
    if let locationName = nameUITextField.text {
      if locationName.characters.count > 0 {
        nameFieldHasText = true
      }
    }
    
    addLocationButton.enabled = nameFieldHasText
    
  }
  
//  MARK: - IBAction(s)
  
  @IBAction func addLocation(sender: UIButton) {
  
  }
  
  
}
