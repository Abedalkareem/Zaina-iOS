//
//  BaseGameViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

open class BaseGameViewController: UIViewController {

  // MARK: - IBOutlet

  @IBOutlet open weak var sceneView: SceneView!

  // MARK: - Properties

  private var timer: Timer?
  private var shouldKeepUpdatingTheScene = true
  open var analogView: AnalogView!

  // MARK: - ViewController lifecycle

  override open func viewDidLoad() {
    super.viewDidLoad()
    addAnalogView()
  }

  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    shouldKeepUpdatingTheScene = true

    startTimer()
  }

  override open func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

    shouldKeepUpdatingTheScene = false

    stopTimer()
  }

  private func addAnalogView() {
    let analogSize: CGFloat = 150
    let margen: CGFloat = 10
    let y = view.bounds.height - (analogSize + margen)
    analogView = AnalogView(frame: CGRect(x: margen, y: y, width: analogSize, height: analogSize))
    analogView.analogImage = #imageLiteral(resourceName: "controller_analog")
    analogView.backgroundImage = #imageLiteral(resourceName: "controller_background")
    view.addSubview(analogView)
  }

  private func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 0.016, target: self, selector: #selector(update), userInfo: nil, repeats: true)
  }

  private func stopTimer() {
    timer?.invalidate()
    timer = nil
  }

  /// override to make changes or move objects.
  @objc
  open func update() {
    checkIfObjectsCollided()
  }

  /// check if any two objects collided.
  open func checkIfObjectsCollided() {
    let subviews = sceneView.subviews.compactMap({ $0 as? ObjectView })
    for object1 in subviews {
      for object2 in subviews {
        if object1 != object2 { 
          if object1.frame.intersects(object2.frame) {
            object1.onCollisionEnter(with: object2)
            object2.onCollisionEnter(with: object1)
            if shouldKeepUpdatingTheScene {
              shouldKeepUpdatingTheScene = objectsDidCollide(object1: object1, object2: object2)
            }
          } else {
            object1.onCollisionEnter(with: nil)
            object2.onCollisionEnter(with: nil)
          }
        }
      }
    }
  }

  /// override this method to get notify when two objects collided.
  /// return true if you want to still get updates aftet two objects collide.
  open func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool { true }

}
