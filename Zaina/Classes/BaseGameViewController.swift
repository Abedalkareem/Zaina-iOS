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

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    startTimer()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopTimer()
  }

  private func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(update), userInfo: nil, repeats: true)
  }

  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }

  @objc
  func update() {
    checkIfObjectsCollided()
  }

  func checkIfObjectsCollided() {
    let subviews = view.subviews.compactMap({ $0 as? ObjectView })
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

  func objectsDidCollide(object1: ObjectView, object2: ObjectView) { }

}
