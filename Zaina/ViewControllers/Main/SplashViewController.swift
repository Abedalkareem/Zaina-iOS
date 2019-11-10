//
//  SplashViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var logoImageView: UIImageView!

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    startTimer()

    hideLogo()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showLogo()
  }

  private func hideLogo() {
    logoImageView.alpha = 0
  }

  private func showLogo() {
    UIView.animate(withDuration: 1.5) {
      self.logoImageView.alpha = 1
    }
  }

  private func startTimer() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
      self.changeViewController(UIStoryboard.create(storyboard: .main, controller: MainViewController.self))
    }
  }

}
