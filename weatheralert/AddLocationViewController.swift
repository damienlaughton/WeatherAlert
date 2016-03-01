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
    let apiWeather = APIWeather()
    
    var locationName = ""
    if let nameLabelText = nameUITextField.text {
      locationName = nameLabelText
    }

//    Not sending a country to the API tends to result in
//    locations that do not have a id.

    var country = "UK"
    if let countryLabelText = countryUITextField.text {
      country = countryLabelText
    }
    
    apiWeather.weather(cityName: locationName, country: country, completion: {(resultObject, status) -> () in
      
      if let statusCode = Int(status) {
        switch statusCode {
        case 200:
          
          if let weatherDictionary = resultObject as? NSDictionary {
            
            let newLocation = Location(weatherDictionary: weatherDictionary)
            
            if let existingLocationManagedObject = self.retrieveExistingLocation(newLocation.locationId) {
            
              self.updateLocation(existingLocationManagedObject, newLocation: newLocation)
              
            } else {
            
              self.persistNewLocation(newLocation)
            }
            
            
          }
          
          break
          
        default:
          //A non 200 code implies an error
          
          
          
          
          
          break
        }
      }
      
      self.performSelectorOnMainThread("tapBackProgrammatically", withObject: .None, waitUntilDone: false)
      
    })
  }
  

}
