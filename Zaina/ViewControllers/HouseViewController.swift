//
//  HouseViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class HouseViewController: BaseGameViewController {

  // MARK: - IBOutlets

  @IBOutlet private weak var analogView: AnalogView!


  // MARK: - Private properties

  private var playerView: ZainaSpriteView!
  private var darkSoulsSpriteViews = [DarkSoulSpriteView]()
  private var points = 0
  private var darkSoulsTimer: Timer?

  // MARK: - ViewController lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    addDarkSouls()

    (0...10).forEach({ _ in addRandomFood() })

    setup()
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    showDialog()
    startDarkSoulTimer()
  }

  private func setup() {
    Status.currentLevel = 1
  }

  private func showDialog() {
    DialogView.showIn(view: view,
                      message: "house_message".localize,
                      firstButtonTitle: "house_message_action".localize)
  }

  private func addDarkSouls() {
    (0...3).forEach { _ in
      let darkSoulSpriteView = DarkSoulSpriteView()
      darkSoulSpriteView.frame.origin = CGPoint(x: 100, y: 100)
      sceneView.addSubview(darkSoulSpriteView)
      darkSoulsSpriteViews.append(darkSoulSpriteView)
    }
  }

  private func startDarkSoulTimer() {
    darkSoulsTimer = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(moveDarkSouls), userInfo: nil, repeats: true)
    moveDarkSouls()
  }

  private func setupPlayer() {
    playerView = ZainaSpriteView()
    playerView.attachTo(analogView)
    playerView.frame.origin = CGPoint(x: sceneView.frame.width - 60, y: 30)
    sceneView.addSubview(playerView)
  }

  @objc
  private func addRandomFood() {
    let food = [#imageLiteral(resourceName: "chocolate"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "chicken"), #imageLiteral(resourceName: "cookie"), #imageLiteral(resourceName: "watermelon"), #imageLiteral(resourceName: "cacke2"), #imageLiteral(resourceName: "soup"), #imageLiteral(resourceName: "eggs"), #imageLiteral(resourceName: "cacke1")]
    let randomX = (50..<Int(sceneView.bounds.width - 50)).randomElement() ?? 0
    let randomY = (50..<Int(sceneView.bounds.height - 50)).randomElement() ?? 0
    let node = NodeView(frame: CGRect(x: randomX, y: randomY, width: 25, height: 25))
    if let image = food.randomElement() {
      node.image = image
      node.type = CollideTypes.food
      sceneView.addSubview(node)
    }
  }

  @objc
  private func moveDarkSouls() {

    darkSoulsSpriteViews.forEach { item in
      let x = CGFloat(Int.random(in: (0...Int(view.frame.width))))
      let y = CGFloat(Int.random(in: (0...Int(view.frame.height))))
      item.moveTo(x: x, y: y)
    }
  }

  private func stopDarkSoulsTimer() {
    darkSoulsTimer?.invalidate()
    darkSoulsTimer = nil
  }

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {

    switch (object1.type, object2.type) {
    case (CollideTypes.zain, CollideTypes.food):
      return collideBetween(zaina: object1, andFood: object2)
    case (CollideTypes.food, CollideTypes.zain):
      return collideBetween(zaina: object2, andFood: object1)
    case (CollideTypes.zain, CollideTypes.exit):
      return collideBetween(zaina: object1, andExit: object2)
    case (CollideTypes.exit, CollideTypes.zain):
      return collideBetween(zaina: object2, andExit: object1)
    case (CollideTypes.zain, CollideTypes.darkSoul):
      return collideBetween(zaina: object1, andDarkSoul: object2)
    case (CollideTypes.darkSoul, CollideTypes.zain):
      return collideBetween(zaina: object2, andDarkSoul: object1)
    default:
      return true
    }
  }

  private func collideBetween(zaina: ObjectView, andFood food: ObjectView) -> Bool {
    food.removeFromSuperview()
    points += 1
    return true
  }

  private func collideBetween(zaina: ObjectView, andExit: ObjectView) -> Bool {
    guard points > 5 else {
      return true
    }
    changeViewController(UIStoryboard.create(storyboard: .main, controller: DiningRoomViewController.self))
    return false
  }

  private func collideBetween(zaina: ObjectView, andDarkSoul: ObjectView) -> Bool {
    changeViewController(UIStoryboard.create(storyboard: .main, controller: GameOverViewController.self))
    return false
  }

}

