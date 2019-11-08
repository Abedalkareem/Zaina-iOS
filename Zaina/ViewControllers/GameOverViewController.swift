//
//  GameOverViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    playBackgroundSong()
  }

  private func playBackgroundSong() {
    MusicPlayer.shared.playBackgroundMusicWith(music: .gameOver)
  }

  // MARK: - IBActions

  @IBAction func tryAgain(_ sender: Any) {
    MusicPlayer.shared.playBackgroundMusicWith(music: .gameOver)
    changeViewController(Status.currentLevelViewController())
  }

}
