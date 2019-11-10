//
//  UIStoryboard.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 01/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

extension UIStoryboard {

  ///
  /// Create new `ViewController` from `Storyboard`.
  /// - Parameter storyboard: The storyboard to instantiate the view controller from.
  /// - Parameter controller: The view controller type that you want to instantiate.
  /// - Parameter bundle: The bundle containing the storyboard file and its resources.
  /// Default value is `Bundle.main`.
  ///
  /// - Returns: A view controller instance.
  ///
  static func create<T>(storyboard: Storyboard,
                        controller: T.Type,
                        bundle: Bundle? = Bundle.main) -> T {
    let uiStoryboard = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    return uiStoryboard.instantiateViewController(withIdentifier: String(describing: controller.self)) as! T
  }
}

///
/// Storyboards used in the app, when you create new `Storyboard` you need to add it here
/// to use it.
///
enum Storyboard: String {
  case main = "Main"
  case house = "House"
}
