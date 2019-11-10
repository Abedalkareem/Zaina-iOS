//
//  HouseExitViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 09/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class HouseExitViewController: BaseGameViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var analogView: AnalogView!

  // MARK: - ViewController lifecycle

  private var playerView: ZainaSpriteView!
  private var omarView: OmarSpriteView!
  private var omarTimer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    setupOmar()
    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    startOmarTimer()
  }

  private func setup() {
    Status.currentLevel = 5
  }

  private func setupPlayer() {
    playerView = ZainaSpriteView()
    playerView.attachTo(analogView)
    playerView.frame.origin = CGPoint(x: view.frame.width - 70, y: view.frame.height / 2)
    sceneView.addSubview(playerView)
  }

  private func setupOmar() {
    omarView = OmarSpriteView()
    omarView.frame.origin = CGPoint(x: view.frame.width - 40, y: view.frame.height / 2)
    omarView.moveTo(x: view.frame.width - 40, y: view.frame.height / 2)
    sceneView.addSubview(omarView)
  }

  private func startOmarTimer() {
    omarTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(moveOmar), userInfo: nil, repeats: true)
    moveOmar()
  }

  @objc
  private func moveOmar() {
    let x = playerView.frame.origin.x + playerView.frame.size.width
    let y = playerView.frame.origin.y + playerView.frame.size.width
    omarView.moveTo(x: x, y: y)
  }

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {

    switch (object1.type, object2.type) {
    case (CollideTypes.zain, CollideTypes.exit):
      return collideBetween(zaina: object1, andExit: object2)
    case (CollideTypes.exit, CollideTypes.zain):
      return collideBetween(zaina: object2, andExit: object1)
    default:
      return true
    }
  }

  private func collideBetween(zaina: ObjectView, andExit: ObjectView) -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .house, controller: HallViewController.self))
    return false
  }
}
