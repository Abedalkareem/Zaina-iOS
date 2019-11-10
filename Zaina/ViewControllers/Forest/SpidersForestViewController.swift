//
//  SpidersForestViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 10/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class SpidersForestViewController: BaseGameViewController {

  // MARK: - Private properties

  private var playerView: ZainaSpriteView!
  private var spiderView: SpiderSpriteView!
  private var spiderTimer: Timer?

  // MARK: - ViewController lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    setupSpider()
    setup()

    startSpiderTimer()
    playBackgroundSong()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showDialog()
  }

  private func setup() {
    Status.currentLevel = 7
  }

  private func showDialog() {
    DialogView.showIn(view: view,
                      message: "intrance_first_message".localize,
                      firstButtonTitle: "intrance_first_message_action".localize)
  }

  private func playBackgroundSong() {
    MusicPlayer.shared.playBackgroundMusicWith(music: .finalFight)
  }

  private func startSpiderTimer() {
     spiderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(moveSpider), userInfo: nil, repeats: true)
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

     switch (object1.type, object2.type) {
     case (CollideTypes.zain, CollideTypes.spider):
       return collideBetween(zaina: object1, andExit: object2)
     case (CollideTypes.spider, CollideTypes.zain):
       return collideBetween(zaina: object2, andExit: object1)
     default:
       return true
     }
   }

   private func collideBetween(zaina: ObjectView, andExit: ObjectView) -> Bool {
     changeViewController(UIStoryboard.create(storyboard: .main, controller: FinishedViewController.self))
     return false
   }
}
