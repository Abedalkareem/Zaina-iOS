//
//  IntranceViewControllerViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class IntranceViewController: BaseGameViewController {

  @IBOutlet private weak var analogView: AnalogView!

  private var playerView: ZainaSpriteView!
  private var spiderView: SpiderSpriteView!

  var spiderTimer: Timer?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    setupSpider()

    startSpiderTimer()
  }

  private func startSpiderTimer() {
    spiderTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveSpider), userInfo: nil, repeats: true)
    moveSpider()
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopSpiderTimer()
  }

  private func stopSpiderTimer() {
    spiderTimer?.invalidate()
    spiderTimer = nil
  }

  @objc
  private func moveSpider() {

    let x = CGFloat(Int.random(in: (0...Int(view.frame.width))))
    let y = CGFloat(Int.random(in: (0...Int(view.frame.height))))

    spiderView.moveTo(x: x, y: y)
  }

  private func setupPlayer() {
    playerView = ZainaSpriteView()
    playerView.stopWhenCollideTypes = [CollideTypes.house, CollideTypes.tree]
    playerView.attachTo(analogView)
    playerView.frame.origin = CGPoint(x: 30, y: 30)
    sceneView.addSubview(playerView)
  }

  private func setupSpider() {
    spiderView = SpiderSpriteView()
    spiderView.stopWhenCollideTypes = [CollideTypes.house, CollideTypes.tree, CollideTypes.zain]
    spiderView.frame.origin = CGPoint(x: 100, y: 100)
    sceneView.addSubview(spiderView)
  }

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {

    if (object1.type == CollideTypes.house && object2.type == CollideTypes.zain)
      || (object2.type == CollideTypes.house && object1.type == CollideTypes.zain) {
      changeViewController(UIStoryboard.create(storyboard: .main, controller: HouseViewController.self))
      return false
    }
    return true
  }

}
