//
//  DiningRoomViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class DiningRoomViewController: BaseGameViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var light1SpriteView: LightNodeView!
  @IBOutlet private weak var light2SpriteView: LightNodeView!
  @IBOutlet private weak var light3SpriteView: LightNodeView!
  @IBOutlet private weak var light4SpriteView: LightNodeView!

  // MARK: - Private properties

  private var playerView: ZainaSpriteView!
  private var omarView: OmarSpriteView!


  // MARK: - ViewController lifecycle

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

  private func showDialog() {
    DialogView.showIn(view: view,
                      message: "dining_room_first_message".localize,
                      firstButtonTitle: "dining_room_first_message_action".localize) { _ in
                        self.showSecondDialog()
    }
  }

  private func showSecondDialog() {
    omarView.moveTo(x: view.frame.width - 50, y: view.frame.height + 50)
    DialogView.showIn(view: view,
                         message: "dining_room_second_message".localize,
                         firstButtonTitle: "dining_room_second_message_action".localize) { _ in

       }
  }

  private func playBackgroundSong() {
    MusicPlayer.shared.playBackgroundMusicWith(music: .piano90e)
  }

  private func setup() {
    Status.currentLevel = 2
  }

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

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {

    switch (object1.type, object2.type) {
    case (CollideTypes.zain, CollideTypes.light):
      return collideBetween(zaina: object1, andLight: object2)
    case (CollideTypes.light, CollideTypes.zain):
      return collideBetween(zaina: object2, andLight: object1)
    case (CollideTypes.zain, CollideTypes.exit):
      return collideBetween(zaina: object1, andExit: object2)
    case (CollideTypes.exit, CollideTypes.zain):
      return collideBetween(zaina: object2, andExit: object1)
    default:
      return true
    }
  }


  private func collideBetween(zaina: ObjectView, andLight light: ObjectView) -> Bool {
    if let light = (light as? LightNodeView) {
      light.isOn = !light.isOn
    }
    return true
  }


  private func collideBetween(zaina: ObjectView, andExit: ObjectView) -> Bool {
    guard light1SpriteView.isOn, light2SpriteView.isOn,
          !light3SpriteView.isOn, light4SpriteView.isOn else {
      return true
    }
    changeViewController(UIStoryboard.create(storyboard: .house, controller: KitchenViewController.self))
    return false
  }

}
