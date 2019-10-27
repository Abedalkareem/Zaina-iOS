//
//  SplashViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    startTimer()
  }

  private func startTimer() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.performSegue(withIdentifier: "mainPage", sender: self)
    }
  }

}
