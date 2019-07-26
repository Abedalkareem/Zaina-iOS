//
//  BaseGameViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class BaseGameViewController: UIViewController {

  var timer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()

    timer = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(update), userInfo: nil, repeats: true)
  }

  @objc
  func update() {
    objectsDidColide()
  }

  func objectsDidColide() {
    let subviews = view.subviews.filter({ $0 is Object })
    for subview in subviews {
      for subView2 in subviews {
        if subview != subView2 {
          if subview.frame.intersects(subView2.frame) {

            print("fucking yea! \((subview as! Object).id), \((subView2 as! Object).id)")
          }
        }
      }
    }
  }
}
