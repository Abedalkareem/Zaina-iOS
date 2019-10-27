//
//  MainViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  @IBOutlet weak var startButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    hideButton()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    showButton()
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

  private func hideButton() {
    startButton.alpha = 0
  }

}
