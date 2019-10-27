//
//  SplashViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

  @IBOutlet weak var logoImageView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    hideLogo()
    startTimer()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showLogo()
  }

  private func hideLogo() {
    logoImageView.alpha = 0
  }

  private func showLogo() {
    UIView.animate(withDuration: 0.5) {
      self.logoImageView.alpha = 1
    }
  }

  private func startTimer() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.performSegue(withIdentifier: "mainPage", sender: self)
    }
  }

}
