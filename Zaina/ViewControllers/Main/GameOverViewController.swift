//
//  GameOverViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import SimpleEngine

class GameOverViewController: UIViewController {

  // MARK: - Private properties

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
    MusicPlayer.shared.playBackgroundMusicWith(music: .piano90e)
    changeViewController(Status.currentLevelViewController())
  }

}
