//
//  AddLocationViewController.swift
//  weatheralert
//
//  Created by Damien Laughton on 29/02/2016.
//  Copyright © 2016 Damien Laughton. All rights reserved.
//

import UIKit

class AddLocationViewController: RootUIViewController {
  
  @IBOutlet weak var backButtonLeadingNSLayoutConstraint: NSLayoutConstraint!
  
  
  //  MARK: - Animation(s)
  
  func animateBackButton(offset newOffset: CGFloat, duration:NSTimeInterval, delay: NSTimeInterval, completionHandler:AnimationCompletionHandler = {}) {
    
    backButtonLeadingNSLayoutConstraint.constant = newOffset
    
    UIView.animateWithDuration(duration, delay: delay, options: .CurveEaseInOut, animations: {
      
      self.view.layoutIfNeeded()
      
      }, completion: { finished in
        
        completionHandler()
    })
  }
  
  //  MARK: - IBAction(s)
  
  @IBAction func back(sender: UIButton) {
    animateBackButton(offset:-6.0, duration:0.05, delay:0.0, completionHandler:{AnimationCompletionHandler in
      self.animateBackButton(offset:0.0, duration:0.1, delay:0.0, completionHandler:{AnimationCompletionHandler in
        
        self.navigationController?.popViewControllerAnimated(true)
        
      })
    })
  }
}
