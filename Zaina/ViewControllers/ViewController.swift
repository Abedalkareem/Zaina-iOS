//
//  ViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 7/21/19.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class ViewController: BaseGameViewController {

  var player: Player!
  var analog: Analog?

  override func viewDidLoad() {
    super.viewDidLoad()

    setupBackground()

    setupPlayer()

    setupEnemy()

    setupController()

  }

  private func setupBackground() {
    let background = Background(frame: view.bounds, image: #imageLiteral(resourceName: "background"))
    view.addSubview(background)
  }

  private func setupController() {
    let controller = Controller(frame: CGRect(x: 20, y: view.bounds.height - 170, width: 150, height: 150))
    view.addSubview(controller)
    controller.analogDidMove { (analog) in
      self.analog = analog
    }
  }

  private func setupPlayer() {
    player = Player(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    player.frames.top = [#imageLiteral(resourceName: "top2"), #imageLiteral(resourceName: "top1")]
    player.frames.left = [#imageLiteral(resourceName: "left2"), #imageLiteral(resourceName: "left1")]
    player.frames.right = [#imageLiteral(resourceName: "right2"), #imageLiteral(resourceName: "right1")]
    player.frames.bottom = [#imageLiteral(resourceName: "bottom1"), #imageLiteral(resourceName: "bottom2")]
    player.frames.idel = [#imageLiteral(resourceName: "idel"), #imageLiteral(resourceName: "idel2")]
    view.addSubview(player)
  }

  private func setupEnemy() {
    let enemy = Player(frame: CGRect(x: 200, y: 200, width: 50, height: 50))
    enemy.frames.top = [#imageLiteral(resourceName: "top2"), #imageLiteral(resourceName: "top1")]
    enemy.frames.left = [#imageLiteral(resourceName: "left2"), #imageLiteral(resourceName: "left1")]
    enemy.frames.right = [#imageLiteral(resourceName: "right2"), #imageLiteral(resourceName: "right1")]
    enemy.frames.bottom = [#imageLiteral(resourceName: "bottom1"), #imageLiteral(resourceName: "bottom2")]
    enemy.frames.idel = [#imageLiteral(resourceName: "idel"), #imageLiteral(resourceName: "idel2")]
    enemy.direction = .center
    view.addSubview(enemy)
  }

  override func update() {
    super.update()
    let x: CGFloat = analog?.x ?? 0
    let y: CGFloat = analog?.y ?? 0
    player.moveWith(x: x, y: y, direction: analog?.direction)
  }

}

