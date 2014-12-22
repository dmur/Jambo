//
//  JamboSupViewController.swift
//  Jambo
//
//  Created by Dolan Murphy on 12/21/14.
//  Copyright (c) 2014 Dolan Murphy. All rights reserved.
//

import UIKit

class JamboSupViewController: UIViewController {

  @IBOutlet weak var jamboHeadWidthConstraint: NSLayoutConstraint!
  @IBOutlet weak var messageLabel: UILabel!
  @IBOutlet weak var jamUsernameField: UITextField!
  @IBOutlet weak var jamUsernameButton: UIButton!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.showJambo()
        // Do any additional setup after loading the view.
    }
  
  func showJambo() {
    self.jamboHeadWidthConstraint.constant = 150
    self.view.setNeedsLayout()
    UIView.animateWithDuration(0.5, delay: 1.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseIn, animations: ({ () -> Void in
      self.view.layoutIfNeeded()
    }), completion: ({ (_) -> Void in
      self.messageLabel.hidden = false
    }))
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
