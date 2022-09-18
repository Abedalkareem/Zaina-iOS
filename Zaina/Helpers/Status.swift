//
//  Status.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

enum Status {

  ///
  /// Return the current level.
  ///
  static var currentLevel: Int {
    get {
      UserDefaults.standard.integer(forKey: "currentLevel")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "currentLevel")
    }
  }

  ///
  /// Return current level view controller.
  ///
  static func currentLevelViewController() -> UIViewController {
    let type: UIViewController.Type
    let storyboard: Storyboard!

    switch currentLevel {
    case 0:
      type = IntranceViewController.self
      storyboard = .forest
    case 1:
      type = HouseViewController.self
      storyboard = .house
    case 2:
      type = DiningRoomViewController.self
      storyboard = .house
    case 3:
      type = KitchenViewController.self
      storyboard = .house
    case 4:
      type = HallViewController.self
      storyboard = .house
    case 5:
      type = HouseExitViewController.self
      storyboard = .house
    case 6:
      type = ForestViewController.self
      storyboard = .forest
    case 7:
      type = SpidersForestViewController.self
      storyboard = .forest
    default:
      type = IntranceViewController.self
      storyboard = .forest
    }

    return UIStoryboard.create(storyboard: storyboard, controller: type)
  }

}
