//
//  JamboSupViewController.swift
//  Jambo
//
//  Created by Dolan Murphy on 12/21/14.
//  Copyright (c) 2014 Dolan Murphy. All rights reserved.
//

import UIKit

class JamboSupViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var jamboHeadWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var jamUsernameField: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.jamUsernameField.delegate = self
    self.showJambo()
  }
  
  func showJambo() {
    self.jamboHeadWidthConstraint.constant = 150
    self.view.setNeedsLayout()
    UIView.animateWithDuration(0.5, delay: 1.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseIn, animations: ({ () -> Void in
      self.view.layoutIfNeeded()
    }), completion: ({ (_) -> Void in
      self.greetUser()
    }))
  }
  
  func greetUser() {
    self.messageLabel.hidden = false
    
    GCD.doAfter(1.5, {
      self.promptForJamUsername()
    });
  }
  
  func promptForJamUsername() {
    self.messageLabel.text = "What's your This is My Jam username?"
    
    UIView.animateWithDuration(0.3, delay: 0, options: nil, animations: { () -> Void in
      self.jamUsernameField.alpha = 1
      }, completion: { (_) in
        self.jamUsernameField.becomeFirstResponder(); return
    })
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    self.performSegueWithIdentifier("ShowJam", sender: nil)
    return true
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "ShowJam") {
      let jamNavigationController = segue.destinationViewController as UINavigationController
      let jamViewController = jamNavigationController.viewControllers[0] as JamViewController
      jamViewController.username = self.jamUsernameField.text
    }
  }
  
}
