//
//  IntranceViewControllerViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class IntranceViewController: BaseGameViewController {

  // MARK: - Private properties

  private var playerView: ZainaSpriteView!

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()

    playBackgroundSong()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showIntranceDialog()
  }

  private func showIntranceDialog() {
    DialogView.showIn(view: view,
                      message: "intrance_first_message".localize,
                      firstButtonTitle: "intrance_first_message_action".localize)
    { _ in
      self.showSecondDialog()
    }
  }

  private func showSecondDialog() {
    DialogView.showIn(view: view,
                      message: "intrance_second_message".localize,
                      firstButtonTitle: "intrance_second_message_action".localize)
  }

  private func playBackgroundSong() {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.darkForest)
  }

  // MARK: - Add sprites

  private func setupPlayer() {
    playerView = ZainaSpriteView()
    playerView.attachTo(analogView)
    playerView.frame.origin = CGPoint(x: view.frame.width / 2 - playerView.width,
                                      y: view.frame.height - playerView.height)
    sceneView.addSubview(playerView)
  }

  // MARK: - Collide

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {
    switch (object1.type, object2.type) {
    case (CollideTypes.house, CollideTypes.zain):
      fallthrough
    case (CollideTypes.zain, CollideTypes.house):
      return enterTheHouse()
    default:
      break
    }
    return true
  }

  private func enterTheHouse() -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .house, controller: HouseViewController.self))
    return false
  }

}
