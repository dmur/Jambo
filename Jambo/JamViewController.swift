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
  @IBOutlet weak var jamInfoBackgroundView: UIImageView!
  @IBOutlet weak var jamTitleLabel: UILabel!
  @IBOutlet weak var jamArtistLabel: UILabel!
  @IBOutlet weak var currentJamIsLabel: UILabel!
  

    override func viewDidLoad() {
        super.viewDidLoad()
      
      let username = "dmur"

      Alamofire.request(.GET, "http://api.thisismyjam.com/1/\(username).json", parameters: nil, encoding: .JSON).responseJSON {
        (_, _, profileData, _) in
        let profile = profileData as NSDictionary,
            jam = profile["jam"] as NSDictionary
        
        self.currentJamIsLabel.text = "\(username)'s current jam is:"
        
        println(profile)
        self.loadJamBackground(jam)
        self.loadJamvatar(jam)
        self.loadJamInfo(jam)
      }
        // Do any additional setup after loading the view.
    }
  
  func loadJamBackground(jam: NSDictionary) {
    let backgroundUrl = NSURL(string: jam["background"] as NSString)
    var imageData = NSData(contentsOfURL: backgroundUrl!)
    let backgroundImage = UIImage(data: imageData!)
    self.jamBackgroundView.image = backgroundImage
    self.jamInfoBackgroundView.image = backgroundImage
  }
  
  func loadJamvatar(jam: NSDictionary) {
    let jamvatarViewWidth = CGRectGetWidth(self.jamvatarView.frame)
    println(jamvatarViewWidth)
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
    
    println(jamvatar!.size)
    self.jamvatarView.image = jamvatar
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
