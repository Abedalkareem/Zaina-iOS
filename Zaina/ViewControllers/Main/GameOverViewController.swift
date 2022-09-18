//
//  GameOverViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class GameOverViewController: UIViewController {

  // MARK: - Private properties

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    playBackgroundSong()
  }

  private func playBackgroundSong() {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.gameOver)
  }

  // MARK: - IBActions

  @IBAction private func tryAgain(_ sender: Any) {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.piano90e)
    changeViewController(Status.currentLevelViewController())
  }

}
