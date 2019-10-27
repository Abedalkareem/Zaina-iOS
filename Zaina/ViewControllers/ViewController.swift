//
//  ViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class ViewController: BaseGameViewController {

  var player: SpriteView!
  var analog: Analog?
  var pointsLabel: UILabel!

  var points = 0 {
    didSet {
      pointsLabel.text = "\(points) Points"
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    setupBackground()
    setupPlayer()
    (0...10).forEach({ _ in addRandomFood() })
    setupAnalogView()
    setupPointsLabel()
    addTree()
  }

  private func setupPointsLabel() {
    pointsLabel = UILabel(frame: CGRect(x: view.bounds.width-130, y: 10, width: 130, height: 30))
    pointsLabel.textColor = .white
    pointsLabel.font = UIFont(name: "RetroComputer", size: 17)
    view.addSubview(pointsLabel)
    points = 0
  }

  private func addTree() {
    let randomX = (100..<Int(view.bounds.width - 50)).randomElement() ?? 0
    let randomY = (100..<Int(view.bounds.height - 50)).randomElement() ?? 0
    let node = NodeView(frame: CGRect(x: randomX, y: randomY, width: 142, height: 165))
    node.image = #imageLiteral(resourceName: "tree2")
    node.type = 3
    view.addSubview(node)
  }

  private func setupBackground() {
    let background = BackgroundView(frame: view.bounds, image: #imageLiteral(resourceName: "background"))
    view.addSubview(background)
  }

  private func setupAnalogView() {
    let controller = AnalogView(frame: CGRect(x: 20, y: view.bounds.height - 170, width: 150, height: 150))
    controller.alpha = 0.7
    view.addSubview(controller)
    controller.analogDidMove { (analog) in
      self.analog = analog
    }
  }

  private func setupPlayer() {
    player = SpriteView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    player.frames.top = [#imageLiteral(resourceName: "top2"), #imageLiteral(resourceName: "top1")]
    player.frames.left = [#imageLiteral(resourceName: "left2"), #imageLiteral(resourceName: "left1")]
    player.frames.right = [#imageLiteral(resourceName: "right2"), #imageLiteral(resourceName: "right1")]
    player.frames.bottom = [#imageLiteral(resourceName: "bottom1"), #imageLiteral(resourceName: "bottom2")]
    player.frames.idel = [#imageLiteral(resourceName: "idel"), #imageLiteral(resourceName: "idel2")]
    player.stopWhenCollideTyps = [3]
    player.type = 1
    view.addSubview(player)
  }

  @objc
  private func addRandomFood() {
    let food = [#imageLiteral(resourceName: "chocolate"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "chicken"),#imageLiteral(resourceName: "cookie"),#imageLiteral(resourceName: "watermelon"),#imageLiteral(resourceName: "cacke2"),#imageLiteral(resourceName: "soup"),#imageLiteral(resourceName: "eggs"),#imageLiteral(resourceName: "cacke1")]
    let randomX = (50..<Int(view.bounds.width - 50)).randomElement() ?? 0
    let randomY = (50..<Int(view.bounds.height - 50)).randomElement() ?? 0
    let node = NodeView(frame: CGRect(x: randomX, y: randomY, width: 40, height: 40))
    if let image = food.randomElement() {
      node.image = image
      node.type = 2
      view.addSubview(node)
    }
  }

  override func update() {
    super.update()
    let x: CGFloat = analog?.x ?? 0
    let y: CGFloat = analog?.y ?? 0
    player.moveXandYBy(x: x, y: y)
  }

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) {
    if object1.type == 2 {
      object1.removeFromSuperview()
      points += 1
    } else if object2.type == 2 {
      object2.removeFromSuperview()
      points += 1
    }
  }

}

