//
//  KitchenViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 09/11/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class KitchenViewController: BaseGameViewController {

  // MARK: - IBOutlets


  // MARK: - Private properties

  private var playerView: ZainaSpriteView!
  private var numberOfDishes = 0
  private var isCooked = false

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    addDishes()
    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    showDialog()
  }

  private func showDialog() {
    DialogView.showIn(view: view,
                      message: "kitchen_room_message".localize,
                      firstButtonTitle: "kitchen_room_message_action".localize)
  }

  private func showCookingDone() {
    DialogView.showIn(view: view,
                      message: "kitchen_room_second_message".localize,
                      firstButtonTitle: "kitchen_room_second_message_action".localize)
  }

  private func setup() {
    Status.currentLevel = 3
  }

  private func addDishes() {
    (1...8).forEach { _ in
      let randomX = (50..<Int(sceneView.bounds.width - 50)).randomElement() ?? 0
      let randomY = (50..<Int(sceneView.bounds.height - 50)).randomElement() ?? 0
      let dishSpriteView = NodeView(frame: CGRect(x: randomX, y: randomY, width: 40, height: 40))
      dishSpriteView.image = #imageLiteral(resourceName: "dish")
      dishSpriteView.type = CollideTypes.dish
      sceneView.addSubview(dishSpriteView)
    }
  }

  private func setupPlayer() {
    playerView = ZainaSpriteView()
    playerView.attachTo(analogView)
    playerView.frame.origin = CGPoint(x: 50, y: 30)
    sceneView.addSubview(playerView)
  }

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {

    switch (object1.type, object2.type) {
    case (CollideTypes.zain, CollideTypes.dish):
      return collideBetween(zaina: object1, andDish: object2)
    case (CollideTypes.dish, CollideTypes.zain):
      return collideBetween(zaina: object2, andDish: object1)
    case (CollideTypes.zain, CollideTypes.exit):
      return collideBetween(zaina: object1, andExit: object2)
    case (CollideTypes.exit, CollideTypes.zain):
      return collideBetween(zaina: object2, andExit: object1)
    case (CollideTypes.zain, CollideTypes.oven):
      return collideBetween(zaina: object1, andOven: object2)
    case (CollideTypes.oven, CollideTypes.zain):
      return collideBetween(zaina: object2, andOven: object1)
    default:
      return true
    }
  }

  private func collideBetween(zaina: ObjectView, andDish dish: ObjectView) -> Bool {
    numberOfDishes += 1
    dish.removeFromSuperview()
    return true
  }

  private func collideBetween(zaina: ObjectView, andOven oven: ObjectView) -> Bool {
    guard numberOfDishes > 4 && !isCooked else {
      return true
    }
    isCooked = true
    showCookingDone()
    MusicPlayer.shared.playMusic(music: .cooking)
    return true
  }

  private func collideBetween(zaina: ObjectView, andExit: ObjectView) -> Bool {
    guard isCooked else {
      return true
    }
    changeViewController(UIStoryboard.create(storyboard: .house, controller: HallViewController.self))
    return false
  }

}
