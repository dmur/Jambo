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

    override func viewDidLoad() {
        super.viewDidLoad()

      Alamofire.request(.GET, "http://api.thisismyjam.com/1/dmur.json", parameters: nil, encoding: .JSON).responseJSON {
        (_, _, profileData, _) in
        let profile = profileData as NSDictionary,
            jam = profile["jam"] as NSDictionary
        let imageUrl = NSURL(string: jam["background"] as NSString)
        var imageData = NSData(contentsOfURL: imageUrl!)
        self.jamBackgroundView.image = UIImage(data: imageData!)
        var img = UIImage(data: imageData!)
        println(img!.size)
      }
        // Do any additional setup after loading the view.
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
