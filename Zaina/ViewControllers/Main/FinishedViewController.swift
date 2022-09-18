//
//  FinishedViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 10/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class FinishedViewController: BaseGameViewController {

  // MARK: - Private properties

  private var zainaSpriteView: ZainaSpriteView!
  private var omarView: OmarSpriteView!

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    addZaina()
    setupOmar()
    playBackgroundSong()
    setup()
  }

  private func setup() {
    analogView.isHidden = true
  }

  private func playBackgroundSong() {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.about)
  }

  // MARK: - Add sprites

  private func addZaina() {
    zainaSpriteView = ZainaSpriteView()
    zainaSpriteView.frame.origin = CGPoint(x: 50, y: 50)
    zainaSpriteView.moveTo(x: 50, y: 50)
    sceneView.addSubview(zainaSpriteView)
  }

  private func setupOmar() {
    omarView = OmarSpriteView()
    omarView.frame.origin = CGPoint(x: view.frame.width - 100, y: 30)
    omarView.moveTo(x: view.frame.width - 100, y: 30)
    sceneView.addSubview(omarView)
  }

  // MARK: - IBActions

  @IBAction private func goBack(_ sender: Any) {
    Status.currentLevel = 0
    changeViewController(UIStoryboard.create(storyboard: .main, controller: MainViewController.self))
  }
}
