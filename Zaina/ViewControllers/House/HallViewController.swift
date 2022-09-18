//
//  HallViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 09/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class HallViewController: BaseGameViewController {

  // MARK: - IBOutlets

  // MARK: - Private properties

  private var isOmarFound = false
  private var playerView: ZainaSpriteView!
  private var omarView: OmarSpriteView!
  private var darkSoulsSpriteViews = [DarkSoulSpriteView]()
  private var darkSoulsTimer: Timer?
  private var omarTimer: Timer?

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    setupOmar()
    addDarkSouls()
    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    showDialog()
    startDarkSoulTimer()
    startOmarTimer()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    stopDarkSoulsTimer()
  }

  private func showDialog() {
    DialogView.showIn(view: view,
                      message: "house_message".localize,
                      firstButtonTitle: "house_message_action".localize)
  }

  private func setup() {
    Status.currentLevel = 4
  }

  // MARK: - Add sprites

  private func setupPlayer() {
    playerView = ZainaSpriteView()
    playerView.attachTo(analogView)
    playerView.frame.origin = CGPoint(x: 50, y: 30)
    sceneView.addSubview(playerView)
  }

  private func setupOmar() {
    omarView = OmarSpriteView()
    omarView.frame.origin = CGPoint(x: view.frame.width - 100, y: 30)
    omarView.moveTo(x: view.frame.width - 100, y: 30)
    sceneView.addSubview(omarView)
  }

  private func addDarkSouls() {
    (0...5).forEach { _ in
      let darkSoulSpriteView = DarkSoulSpriteView()
      darkSoulSpriteView.frame.origin = CGPoint(x: 100, y: 100)
      sceneView.addSubview(darkSoulSpriteView)
      darkSoulsSpriteViews.append(darkSoulSpriteView)
    }
  }

  // MARK: - Moving

  @objc
  private func moveDarkSouls() {

    darkSoulsSpriteViews.forEach { item in
      let x = CGFloat(Int.random(in: (0...Int(view.frame.width))))
      let y = CGFloat(Int.random(in: (0...Int(view.frame.height))))
      item.moveTo(x: x, y: y)
    }
  }

  @objc
  private func moveOmar() {
    let randomX = CGFloat(Int.random(in: (0...Int(view.frame.width))))
    let randomY = CGFloat(Int.random(in: (0...Int(view.frame.height))))
    let x = isOmarFound ? (playerView.frame.origin.x - playerView.frame.size.width) : randomX
    let y = isOmarFound ? (playerView.frame.origin.y - playerView.frame.size.width) : randomY
    omarView.moveTo(x: x, y: y)
  }

  // MARK: - Timers

  private func startDarkSoulTimer() {
    darkSoulsTimer = Timer.scheduledTimer(timeInterval: 4,
                                          target: self,
                                          selector: #selector(moveDarkSouls),
                                          userInfo: nil,
                                          repeats: true)
    moveDarkSouls()
  }

  private func startOmarTimer() {
    omarTimer = Timer.scheduledTimer(timeInterval: isOmarFound ? 0.5 : 2,
                                     target: self,
                                     selector: #selector(moveOmar),
                                     userInfo: nil,
                                     repeats: true)
    moveOmar()
  }

  private func stopDarkSoulsTimer() {
    darkSoulsTimer?.invalidate()
    darkSoulsTimer = nil
  }

  private func stopOmarTimer() {
    omarTimer?.invalidate()
    omarTimer = nil
  }

  // MARK: - Collide

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {

    switch (object1.type, object2.type) {
    case (CollideTypes.zain, CollideTypes.omar):
      return collideBetween(zaina: object1, andOmar: object2)
    case (CollideTypes.omar, CollideTypes.zain):
      return collideBetween(zaina: object2, andOmar: object1)
    case (CollideTypes.zain, CollideTypes.exit):
      return collideBetween(zaina: object1, andExit: object2)
    case (CollideTypes.exit, CollideTypes.zain):
      return collideBetween(zaina: object2, andExit: object1)
    case (CollideTypes.zain, CollideTypes.darkSoul):
      return collideBetween(zaina: object1, andDarkSoul: object2)
    case (CollideTypes.darkSoul, CollideTypes.zain):
      return collideBetween(zaina: object2, andDarkSoul: object1)
    default:
      return true
    }
  }

  private func collideBetween(zaina: ObjectView, andOmar omar: ObjectView) -> Bool {
    guard !isOmarFound else {
      return true
    }
    isOmarFound = true
    startOmarTimer()
    return true
  }

  private func collideBetween(zaina: ObjectView, andExit: ObjectView) -> Bool {
    guard isOmarFound else {
      return true
    }
    changeViewController(UIStoryboard.create(storyboard: .house, controller: HouseExitViewController.self))
    return false
  }

  private func collideBetween(zaina: ObjectView, andDarkSoul: ObjectView) -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .main, controller: GameOverViewController.self))
    return false
  }
}
