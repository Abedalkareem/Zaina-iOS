//
//  HouseViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class HouseViewController: BaseGameViewController {

  @IBOutlet private weak var analogView: AnalogView!

  private var playerView: ZainaSpriteView!
  private var pointsLabel: UILabel!

  var points = 0 {
    didSet {
      pointsLabel.text = "\(points) Points"
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()
    (0...10).forEach({ _ in addRandomFood() })
    setupPointsLabel()
  }

  private func setupPointsLabel() {
    pointsLabel = UILabel(frame: CGRect(x: sceneView.bounds.width-130, y: 10, width: 130, height: 30))
    pointsLabel.textColor = .white
    pointsLabel.font = UIFont(name: "RetroComputer", size: 17)
    sceneView.addSubview(pointsLabel)
    points = 0
  }

  private func setupPlayer() {
    playerView = ZainaSpriteView()
    playerView.stopWhenCollideTypes = [CollideTypes.houseExitToIntrance,
                                       CollideTypes.food, CollideTypes.tree]
    playerView.attachTo(analogView)
    playerView.frame.origin = CGPoint(x: sceneView.frame.width - 60, y: 30)
    sceneView.addSubview(playerView)
  }

  @objc
  private func addRandomFood() {
    let food = [#imageLiteral(resourceName: "chocolate"), #imageLiteral(resourceName: "apple"), #imageLiteral(resourceName: "chicken"), #imageLiteral(resourceName: "cookie"), #imageLiteral(resourceName: "watermelon"), #imageLiteral(resourceName: "cacke2"), #imageLiteral(resourceName: "soup"), #imageLiteral(resourceName: "eggs"), #imageLiteral(resourceName: "cacke1")]
    let randomX = (50..<Int(sceneView.bounds.width - 50)).randomElement() ?? 0
    let randomY = (50..<Int(sceneView.bounds.height - 50)).randomElement() ?? 0
    let node = NodeView(frame: CGRect(x: randomX, y: randomY, width: 40, height: 40))
    if let image = food.randomElement() {
      node.image = image
      node.type = CollideTypes.food
      sceneView.addSubview(node)
    }
  }

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) -> Bool {
    if (object1.type == CollideTypes.food && object2.type == CollideTypes.zain) ||
      (object2.type == CollideTypes.food && object1.type == CollideTypes.zain) {
      (object1 as? NodeView)?.removeFromSuperview()
      (object2 as? NodeView)?.removeFromSuperview()
      points += 1
    } else if (object1.type == CollideTypes.houseExitToIntrance && object2.type == CollideTypes.zain) ||
    (object2.type == CollideTypes.houseExitToIntrance && object1.type == CollideTypes.zain) {
      changeViewController(UIStoryboard.create(storyboard: .main, controller: IntranceViewController.self))
      return false
    }
    return true
  }

}

