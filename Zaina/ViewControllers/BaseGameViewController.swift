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
    checkIfObjectsCollided()
  }

  func checkIfObjectsCollided() {
    let subviews = view.subviews.compactMap({ $0 as? Object })
    for object1 in subviews {
      for object2 in subviews {
        if object1 != object2 { 
          if object1.frame.intersects(object2.frame) {
            object1.onCollisionEnter(with: object2)
            object2.onCollisionEnter(with: object1)
            objectsDidCollide(object1: object1, object2: object2)
            return
          } else {
            object1.onCollisionEnter(with: nil)
            object2.onCollisionEnter(with: nil)
          }
        }
      }
    }
  }

  func objectsDidCollide(object1: Object, object2: Object) { }

}
