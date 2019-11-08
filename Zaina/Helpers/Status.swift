//
//  Status.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 08/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class Status {

  static var currentLevel: Int {
    get {
      return UserDefaults.standard.integer(forKey: "currentLevel")
    }
    set {
      UserDefaults.standard.set(newValue, forKey: "currentLevel")
    }
  }

  static func currentLevelViewController() -> UIViewController {
    let type: UIViewController.Type?

    switch currentLevel {
    case 0:
      type = IntranceViewController.self
    case 1:
      type = HouseViewController.self
    case 2:
      type = DiningRoomViewController.self
    default:
      type = IntranceViewController.self
    }

    return UIStoryboard.create(storyboard: .main, controller: type!)
  }

}
