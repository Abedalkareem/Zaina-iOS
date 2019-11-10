//
//  HouseExitViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 09/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class HouseExitViewController: BaseGameViewController {

  // MARK: - IBOutlets

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
  }

  private func setup() {
    Status.currentLevel = 5
  }

  

  private func collideBetween(zaina: ObjectView, andExit: ObjectView) -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .house, controller: HallViewController.self))
    return false
  }

  private func collideBetween(zaina: ObjectView, andDarkSoul: ObjectView) -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .main, controller: GameOverViewController.self))
    return false
  }
}
