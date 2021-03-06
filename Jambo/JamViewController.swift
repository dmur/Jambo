//
//  JamViewController.swift
//  Jambot
//
//  Created by Dolan Murphy on 12/20/14.
//  Copyright (c) 2014 Dolan Murphy. All rights reserved.
//

import UIKit
import Alamofire

class JamViewController: UIViewController {
  
    
  @IBOutlet weak var jamBackgroundView: UIImageView!
  @IBOutlet weak var jamvatarView: UIImageView!
  @IBOutlet weak var jamvatarBorderView: UIView!
  @IBOutlet weak var jamInfoBackgroundView: UIImageView!
  @IBOutlet weak var jamTitleLabel: UILabel!
  @IBOutlet weak var jamArtistLabel: UILabel!
  @IBOutlet weak var currentJamIsLabel: UILabel!
  @IBOutlet weak var loadingSpinner: UIActivityIndicatorView!
  
  var username: String = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "\(self.username)'s jam"
    self.loadingSpinner.startAnimating()

    Alamofire.request(.GET, "http://api.thisismyjam.com/1/\(self.username).json", parameters: nil, encoding: .JSON).responseJSON {
      (_, _, profileData, _) in
      self.loadingSpinner.stopAnimating()
      
      let profile = profileData as NSDictionary?
      if (profile != nil) {
        let jam = profile!["jam"] as NSDictionary?
        let person = profile!["person"] as NSDictionary?
        if (jam != nil) { self.loadJam(jam!) }
        else { self.goBackToJambo(person != nil ? "No current jam for \(self.username)" : nil) }
      } else { self.goBackToJambo(nil) }
    }
  }
  
  func goBackToJambo(message: String?) {
    self.currentJamIsLabel.text = message ?? "No profile found for \(self.username)"
    GCD.doAfter(1.5, { self.performSegueWithIdentifier("ShowJambo", sender: nil) })
  }
  
  func loadJam(jam: NSDictionary) {
    self.loadingSpinner.stopAnimating()
    self.navigationController?.setNavigationBarHidden(false, animated: true)
    
    self.currentJamIsLabel.text = "\(self.username)'s current jam is:"
    self.loadJamBackground(jam)
    self.loadJamvatar(jam)
    self.loadJamInfo(jam)
  }
  
  func loadJamBackground(jam: NSDictionary) {
    let backgroundUrl = NSURL(string: jam["background"] as NSString)
    var imageData = NSData(contentsOfURL: backgroundUrl!)
    let backgroundImage = UIImage(data: imageData!)
    self.jamBackgroundView.image = backgroundImage
    self.jamInfoBackgroundView.image = backgroundImage
    
    // Add parallax
    let horizontalOffset = 0.025 * CGRectGetWidth(UIScreen.mainScreen().bounds)
    let verticalOffset = 0.025 * CGRectGetHeight(UIScreen.mainScreen().bounds)
    
    let horizontalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
    horizontalMotionEffect.minimumRelativeValue = -horizontalOffset
    horizontalMotionEffect.maximumRelativeValue = horizontalOffset
    let verticalMotionEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .TiltAlongVerticalAxis)
    verticalMotionEffect.minimumRelativeValue = -verticalOffset
    verticalMotionEffect.maximumRelativeValue = verticalOffset
    
    let parallaxEffect = UIMotionEffectGroup()
    parallaxEffect.motionEffects = [horizontalMotionEffect, verticalMotionEffect]
    self.jamvatarBorderView.addMotionEffect(parallaxEffect)
    self.currentJamIsLabel.addMotionEffect(parallaxEffect)
    self.jamTitleLabel.addMotionEffect(parallaxEffect)
    self.jamArtistLabel.addMotionEffect(parallaxEffect)
  }
  
  func loadJamvatar(jam: NSDictionary) {
    let jamvatarViewWidth = CGRectGetWidth(self.jamvatarView.frame)
    var jamvatarKey = "jamvatarSmall"
    let screenScale = UIScreen.mainScreen().scale
    if (jamvatarViewWidth >  185/screenScale) {
      jamvatarKey = "jamvatarLarge"
    } else if (jamvatarViewWidth > 80/screenScale) {
      jamvatarKey = "jamvatarMedium"
    }
    
    let jamvatarUrl = NSURL(string: jam[jamvatarKey] as NSString)
    var imageData = NSData(contentsOfURL: jamvatarUrl!)
    var jamvatar = UIImage(data: imageData!)
    
    self.jamvatarView.image = jamvatar
    
    self.jamvatarBorderView.backgroundColor = UIColor(white: 0, alpha:0.2)
  }
  
  func loadJamInfo(jam: NSDictionary) {
    let jamArtist = jam["artist"] as NSString,
        jamTitle = jam["title"] as NSString,
        jamColor = UIColor(red: 0.3, green: 0.3, blue: 0.1, alpha: 1.0)
    
    self.jamTitleLabel.text = jamTitle
    self.jamTitleLabel.textColor = jamColor
    
    var artistString = NSMutableAttributedString(string: "by \(jamArtist)")
    artistString.addAttribute(NSForegroundColorAttributeName, value: UIColor(white: 0.2, alpha: 1.0), range: NSMakeRange(0, 3))
    artistString.addAttribute(NSForegroundColorAttributeName, value: jamColor, range: NSMakeRange(3, artistString.length - 3))
    self.jamArtistLabel.attributedText = artistString
  }

}
