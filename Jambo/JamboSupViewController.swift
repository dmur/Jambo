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
    GCD.doAfter(1.0, {
      self.showJambo({ (_) in self.greetUser() })
    })
    
  }
  
  @IBAction func tapJambo(sender: AnyObject) {
    self.showJambo({ (_) in nil })
  }
  
  func showJambo(completion: (Bool) -> Void?) {
    if (self.jamboHeadWidthConstraint.constant) != 20 {
      self.jamboHeadWidthConstraint.constant = 20
      self.view.setNeedsLayout()
      self.view.layoutIfNeeded()
    }
    self.jamboHeadWidthConstraint.constant = 150
    self.view.setNeedsLayout()
    UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.02, options: nil, animations: { self.view.layoutIfNeeded() }, completion: { (c) in completion(c); return })
  }
  
  func greetUser() {
    self.messageLabel.hidden = false
    
    GCD.doAfter(1.5, { self.promptForJamUsername() });
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
