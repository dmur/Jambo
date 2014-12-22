//
//  GCD.swift
//  Jambo
//
//  Created by Dolan Murphy on 12/22/14.
//  Copyright (c) 2014 Dolan Murphy. All rights reserved.
//

import UIKit

class GCD: NSObject {
  class func doAfter(seconds: Double, task: () -> Void) {
    let delayTime: dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW,
      Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(delayTime, dispatch_get_main_queue()) {
      task()
    }
  }
}
