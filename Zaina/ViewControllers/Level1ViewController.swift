//
//  Level1ViewController.swift
//  Zaina
//
//  Created by abedalkareem omreyh on 27/10/2019.
//  Copyright © 2019 abedalkareem. All rights reserved.
//

import UIKit

class Level1ViewController: BaseGameViewController {

  @IBOutlet private weak var playerView: SpriteView!
  @IBOutlet private weak var analogView: AnalogView!

  override func viewDidLoad() {
    super.viewDidLoad()

    setupPlayer()

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.playerView.moveTo(x: 400, y: 150)
    }
  }

  private func setupPlayer() {
    playerView.frames.top = [#imageLiteral(resourceName: "top2"), #imageLiteral(resourceName: "top1")]
    playerView.frames.left = [#imageLiteral(resourceName: "left2"), #imageLiteral(resourceName: "left1")]
    playerView.frames.right = [#imageLiteral(resourceName: "right2"), #imageLiteral(resourceName: "right1")]
    playerView.frames.bottom = [#imageLiteral(resourceName: "bottom1"), #imageLiteral(resourceName: "bottom2")]
    playerView.frames.idel = [#imageLiteral(resourceName: "idel"), #imageLiteral(resourceName: "idel2")]
    playerView.stopWhenCollideTyps = [3, 4]
    playerView.attachTo(analogView)
  }

  override func objectsDidCollide(object1: ObjectView, object2: ObjectView) {

    if object1.type == 4 {
      self.performSegue(withIdentifier: "housePage", sender: nil)
    } else if object2.type == 4 {
      self.performSegue(withIdentifier: "housePage", sender: nil)
    }

  }

}
