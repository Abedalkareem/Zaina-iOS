//
//  ForestViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 10/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class ForestViewController: BaseGameViewController {

  // MARK: - Private properties

  private var playerView: ZainaSpriteView!
  private var omarView: OmarSpriteView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    setupOmar()
    setup()
    playBackgroundSong()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    showDialog()
  }

  private func setup() {
    Status.currentLevel = 6
  }

  private func playBackgroundSong() {
    MusicPlayer.shared.playBackgroundMusicWith(music: .youWin)
  }

  private func showDialog() {
    DialogView.showIn(view: view,
                      message: "forest_message".localize,
                      firstButtonTitle: "forest_message_action".localize) { _ in
      self.omarView.moveTo(x: self.view.frame.width + 50, y: self.omarView.frame.origin.y)
      self.showSecondDialog()
    }
  }

  private func showSecondDialog() {
    DialogView.showIn(view: view,
                      message: "forest_second_message".localize,
                      firstButtonTitle: "forest_second_message_action".localize)
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
    changeViewController(UIStoryboard.create(storyboard: .forest, controller: SpidersForestViewController.self))
    return false
  }

}
