//
//  GameOverViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit
import GoogleMobileAds

class GameOverViewController: UIViewController {

  // MARK: - Private properties

  private var interstitial: GADInterstitial!

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    playBackgroundSong()
    setupAd()
  }

  private func setupAd() {
    interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
    interstitial.delegate = self
    let request = GADRequest()
    interstitial.load(request)
  }
  
  private func playBackgroundSong() {
    MusicPlayer.shared.playBackgroundMusicWith(music: .gameOver)
  }

  // MARK: - IBActions

  @IBAction func tryAgain(_ sender: Any) {
    if interstitial.isReady {
      interstitial.present(fromRootViewController: self)
    } else {
      MusicPlayer.shared.playBackgroundMusicWith(music: .piano90e)
      changeViewController(Status.currentLevelViewController())
    }
  }

}

extension GameOverViewController: GADInterstitialDelegate {
  func interstitialDidDismissScreen(_ ad: GADInterstitial) {
    MusicPlayer.shared.playBackgroundMusicWith(music: .piano90e)
    changeViewController(Status.currentLevelViewController())
  }
}
