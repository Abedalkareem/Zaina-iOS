//
//  MainViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

class MainViewController: BaseGameViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var startButton: UIButton!
  @IBOutlet private weak var logoImageView: UIImageView!

  // MARK: - Properties

  private var zainaSpriteView: ZainaSpriteView!
  private var zainaMovingTimer: Timer?

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    hideViews()
    addZaina()
    playBackgroundSong()

    setupViews()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showButton()
    showLogo()
    startZainaMovingTimer()
  }

  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(true)
    stopZainaMovingTimer()
  }

  private func setupViews() {
    let title = Status.currentLevel == 0 ? "Start" : "Continue"
    startButton.setTitle(title, for: .normal)
    analogView.isHidden = true
  }

  private func playBackgroundSong() {
    SimpleMusicPlayer.shared.playBackgroundMusicWith(music: Music.mainScreen)
  }

  private func showButton() {
    let orginalFrame = startButton.frame
    var newFrame = orginalFrame
    newFrame.origin.y = view.frame.height
    startButton.frame = newFrame
    startButton.alpha = 1
    UIView.animate(withDuration: 1.5) {
      self.startButton.frame = orginalFrame
    }
  }

  private func showLogo() {
    UIView.animate(withDuration: 1.5) {
      self.logoImageView.alpha = 1
    }
  }

  private func hideViews() {
    startButton.alpha = 0
    logoImageView.alpha = 0
  }

  // MARK: - Add sprites

  private func addZaina() {
    zainaSpriteView = ZainaSpriteView()
    zainaSpriteView.frame.origin = CGPoint(x: 30, y: 30)
    sceneView.addSubview(zainaSpriteView)
  }

  // MARK: - Timers

  private func startZainaMovingTimer() {
    zainaMovingTimer = Timer.scheduledTimer(timeInterval: 4,
                                            target: self,
                                            selector: #selector(moveZaina),
                                            userInfo: nil,
                                            repeats: true)
    moveZaina()
  }

  private func stopZainaMovingTimer() {
    zainaMovingTimer?.invalidate()
    zainaMovingTimer = nil
  }

  @objc
  private func moveZaina() {
    let x = CGFloat(Int.random(in: (0...Int(view.frame.width))))
    let y = CGFloat(Int.random(in: (0...Int(view.frame.height))))

    zainaSpriteView.moveTo(x: x, y: y)
  }

  // MARK: - IBActions

  @IBAction private func start(_ sender: Any) {
    changeViewController(Status.currentLevelViewController())
  }

}
