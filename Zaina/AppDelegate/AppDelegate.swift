//
//  AppDelegate.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import SimpleEngine
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    setupAnalogViewSettings()

    DialogView.fontName = "RetroComputer"

    return true
  }

  private func setupAnalogViewSettings() {
    AnalogView.Settings.analogImage = #imageLiteral(resourceName: "controller_analog")
    AnalogView.Settings.backgroundImage = #imageLiteral(resourceName: "controller_background")
    AnalogView.Settings.alpha = 0.7
  }

  func applicationWillResignActive(_ application: UIApplication) { }

  func applicationDidEnterBackground(_ application: UIApplication) { }

  func applicationWillEnterForeground(_ application: UIApplication) { }

  func applicationDidBecomeActive(_ application: UIApplication) { }

  func applicationWillTerminate(_ application: UIApplication) { }

}
