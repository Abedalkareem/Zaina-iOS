//
//  UIViewController.swift
//  SimpleEngine
//
//  Created by abedalkareem omreyh on 01/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

public extension UIViewController {

  private var appWindow: UIWindow? {
    UIApplication.shared.connectedScenes
      .compactMap { $0 as? UIWindowScene }
      .first { $0.activationState == .foregroundActive }?
      .windows
      .first { $0.isKeyWindow }
  }

  ///
  /// Use it to change the root view controller.
  /// - Parameter viewController: A view controller to set as a root.
  /// - Parameter animated: A bool value to determine either changing the view controller
  ///  should set as root with animation or not.
  ///
  func changeViewController(_ viewController: UIViewController?, animated: Bool = true) {

    guard let window = appWindow else {
      return
    }

    guard animated else {
      window.rootViewController = viewController
      return
    }

    let view = UIView(frame: window.bounds)
    view.backgroundColor = .black
    window.addSubview(view)
    view.alpha = 0
    UIView.animate(withDuration: 0.5,
                   animations: {
      view.alpha = 1
    }, completion: { _ in
      window.rootViewController = viewController
      view.removeFromSuperview()
    })
  }

}
