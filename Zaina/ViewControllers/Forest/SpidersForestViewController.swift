//
//  SpidersForestViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 10/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class SpidersForestViewController: BaseGameViewController {

  // MARK: - Private properties

  private var playerView: ZainaSpriteView!
  private var spiderView: SpiderSpriteView!
  private var spiderTimer: Timer?
  private var knifeButton: UIButton!

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    setupSpider()
    setup()

    startSpiderTimer()
    playBackgroundSong()
    addKnifeButton()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showDialog()
  }

  private func setup() {
    Status.currentLevel = 7
  }

  private func addKnifeButton() {
    knifeButton = UIButton()
    knifeButton.setImage(#imageLiteral(resourceName: "knife_button"), for: .normal)
    knifeButton.addTarget(self, action: #selector(fire), for: .touchUpInside)
    knifeButton.alpha = 0.7
    view.addSubview(knifeButton)

    makeKnifeButtonConstraints()
  }

  private func makeKnifeButtonConstraints() {
    let size: CGFloat = 100
    let margen: CGFloat = 15
    knifeButton.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      knifeButton.widthAnchor.constraint(equalToConstant: size),
      knifeButton.heightAnchor.constraint(equalToConstant: size),
      knifeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -margen),
      knifeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -margen)
    ])
  }

  private func showDialog() {
    DialogView.showIn(view: view,
                      message: "intrance_first_message".localize,
                      firstButtonTitle: "intrance_first_message_action".localize)
  }

  private func playBackgroundSong() {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.finalFight)
  }

  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    stopSpiderTimer()
  }

  // MARK: - Timers

  private func stopSpiderTimer() {
    spiderTimer?.invalidate()
    spiderTimer = nil
  }

  private func startSpiderTimer() {
    spiderTimer = Timer.scheduledTimer(timeInterval: 1,
                                       target: self,
                                       selector: #selector(moveSpider),
                                       userInfo: nil,
                                       repeats: true)
    moveSpider()
  }

  // MARK: - Moving

  @objc
  private func moveSpider() {

    let x = CGFloat(Int.random(in: (0...Int(view.frame.width))))
    let y = CGFloat(Int.random(in: (0...Int(view.frame.height))))

    spiderView.moveTo(x: x, y: y)
  }

  // MARK: - Add sprites

  private func setupPlayer() {
    playerView = ZainaSpriteView()
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

  // MARK: - Actions

  @objc
  private func fire() {
    playerView.fire()
  }

  // MARK: - Collide

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {

    switch (object1.type, object2.type) {
    case (CollideTypes.zain, CollideTypes.spider):
      return collideBetween(zaina: object1, andSpider: object2)
    case (CollideTypes.spider, CollideTypes.zain):
      return collideBetween(zaina: object2, andSpider: object1)
    case (CollideTypes.fire, CollideTypes.spider):
      return collideBetween(fire: object1, andSpider: object2)
    case (CollideTypes.spider, CollideTypes.fire):
      return collideBetween(fire: object2, andSpider: object1)
    default:
      return true
    }
  }

  private func collideBetween(zaina: ObjectView, andSpider: ObjectView) -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .main, controller: GameOverViewController.self))
    return false
  }

  private func collideBetween(fire: ObjectView, andSpider: ObjectView) -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .main, controller: FinishedViewController.self))
    return false
  }
}
